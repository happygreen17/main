package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class BbsDAO {
	
	public int total(Map map) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) as cnt from bbs "); //count로 전체 레코드 갯수를 가져올 수 있다
		if(word.trim().length()>0)
			sql.append(" where "+col+ " like '%'||?||'%' ");


		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				pstmt.setString(1, word);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt("cnt");   //count(*)를 말함
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return total;
	}
	
	
	public boolean checkRefnum(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(refnum) from bbs  "); // count(refnum) : refnum의 갯수(댓글의 갯수)
		sql.append(" where refnum = ?  ");       //bbsno와 refnum(자식은 부모의 bbsno를 가진다)이 같은 것
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();		
			if(rs.next()) {
				int cnt = rs.getInt("count(refnum)");
				if(cnt > 0)flag = true; // 답변이 있는부모글이다
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	
	
	public BbsDTO readReply(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select bbsno, grpno, indent, ansnum, title  ");
		sql.append(" from bbs  ");
		sql.append("  where bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setTitle(rs.getString("title"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public void updateAnsnum(Map map){
		int grpno = (Integer) map.get("grpno");
		int ansnum = (Integer) map.get("ansnum");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("  update bbs ");
		sql.append(" set ansnum = ansnum + 1  ");
		sql.append(" where grpno = ? and ansnum > ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}
	}
	
	public boolean createReply(BbsDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into bbs ");
		sql.append(" (id, bbsno, wname, title, content, wdate, grpno, indent, ansnum, refnum, filename, filesize) ");
		sql.append(" values(?, (select nvl(max(bbsno), 0) + 1 as bbsno from bbs), ");
		sql.append(" ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getGrpno());          //부모것 그대로
			pstmt.setInt(6, dto.getIndent() + 1);     //부모것 +1 (깊이)
			pstmt.setInt(7, dto.getAnsnum() + 1);     //부모것 +1 (순서)
			pstmt.setInt(8, dto.getBbsno());          //부모의 글번호
			pstmt.setString(9, dto.getFilename()); 
			pstmt.setInt(10, dto.getFilesize()); 
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0)flag = true;
						
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public List<BbsDTO> list(Map map){
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");  /*Object와 상속관계이므로 형변환 가능*/
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT id, bbsno, wname, title, viewcnt, wdate, indent, filename, r ");
		sql.append("from( ");
		sql.append("	SELECT id, bbsno, wname, title, viewcnt, wdate, indent, filename, rownum r ");
		sql.append("	from( ");
		sql.append(" 		SELECT id, bbsno, wname, title, viewcnt, to_char(wdate, 'yyyy-MM-dd') wdate ");
		sql.append(" 		,indent, filename ");
		sql.append(" 		FROM bbs ");
		
		if(word.trim().length()>0) 
			sql.append(" 	where "+col+" like '%'||?||'%' ");

		sql.append(" 		ORDER BY grpno DESC, ansnum ASC ");
		sql.append(" 		) ");
		sql.append(" 	) ");
		sql.append(" where r >= ? and r <= ? ");
		 
		try {
		pstmt = con.prepareStatement(sql.toString());
		
		int i = 0;
		
		if(word.trim().length()>0)
			pstmt.setString(++i, word);
		
		/*word가 있을수도 있고 없을수도 있으므로 변수 i 선언*/
		pstmt.setInt(++i, sno);
		pstmt.setInt(++i, eno);
		 
		rs = pstmt.executeQuery();
		 
		while(rs.next()){
		BbsDTO dto = new BbsDTO();
		dto.setId(rs.getString("id"));
		dto.setBbsno(rs.getInt("bbsno"));
		dto.setWname(rs.getString("wname"));
		dto.setTitle(rs.getString("title"));
		dto.setViewcnt(rs.getInt("viewcnt"));
		dto.setWdate(rs.getString("wdate"));
		dto.setIndent(rs.getInt("indent"));
		dto.setFilename(rs.getString("filename"));
		 
		list.add(dto);
		}
		 
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		} finally{
		DBClose.close(con, pstmt, rs);
		}
		 
		return list;
	}
	
	public List<BbsDTO> list(){
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT id, bbsno, title, viewcnt, wdate, indent,  r ");
		sql.append("from( ");
		sql.append("	SELECT id, bbsno, title, viewcnt, wdate, indent, rownum r ");
		sql.append("	from( ");
		sql.append(" 		SELECT id, bbsno, title, viewcnt, to_char(wdate, 'yyyy-MM-dd') wdate, indent ");
		sql.append(" 		FROM bbs ");
		sql.append(" 		where indent = 0 ");
		sql.append(" 		ORDER BY grpno DESC, ansnum ASC ");
		sql.append(" 		) ");
		sql.append(" 	) ");
		sql.append(" where r >= 1 and r <= 5 ");
		 
		try {
		pstmt = con.prepareStatement(sql.toString());
		 
		rs = pstmt.executeQuery();
		 
		while(rs.next()){
		BbsDTO dto = new BbsDTO();
		dto.setId(rs.getString("id"));
		dto.setBbsno(rs.getInt("bbsno"));
		dto.setTitle(rs.getString("title"));
		dto.setViewcnt(rs.getInt("viewcnt"));
		dto.setWdate(rs.getString("wdate"));
		dto.setIndent(rs.getInt("indent"));
		 
		list.add(dto);
		}
		 
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		} finally{
		DBClose.close(con, pstmt, rs);
		}
		 
		return list;
	}

	public BbsDTO read(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, viewcnt, wdate, content ");
		sql.append(" , filename, filesize ");
		sql.append(" FROM bbs   ");
		sql.append(" WHERE bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return dto;
	}
	
	public String readId(int bbsno) {
		String id = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT id ");
		sql.append(" FROM bbs   ");
		sql.append(" WHERE bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}		
		return id;
	}
	
	public String readMname(String id) {
		String mname = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT mname ");
		sql.append(" FROM member   ");
		sql.append(" WHERE id = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				mname = rs.getString("mname");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return mname;
	}

	public void upViewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update bbs ");
		sql.append(" set viewcnt = viewcnt + 1 ");
		sql.append(" where bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

	}

	public boolean create(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO bbs(id, bbsno, wname, title, ");
		sql.append(" content, wdate, grpno, filename, filesize)   ");
		sql.append(" VALUES( ");
		sql.append(" ?, (SELECT NVL(MAX(bbsno), 0)+1 FROM bbs),");
		sql.append(" ?, ?, ?, sysdate, ");
		sql.append(" (select nvl(max(grpno),0)+1 from bbs), ?, ?) ");         //맨처음 부모글 만들때 grpno를 1로 해주고 다음에 만들때는 +1시키다

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public boolean update(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs  ");
		sql.append(" SET         ");
		sql.append("    	wname   = ?,  ");
		sql.append("    	title   = ?,  ");
		sql.append("   		content = ?  ");
		if(dto.getFilesize()>0) {
			sql.append(" ,  filename  = ?,  ");
			sql.append(" 	filesize  = ?  ");
		}
		sql.append(" WHERE bbsno  = ?  ");

		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			
			if(dto.getFilesize()>0) {
				pstmt.setString(++i, dto.getFilename());
				pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getBbsno());

			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}

	public boolean delete(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from bbs ");
		sql.append(" where bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}
}
