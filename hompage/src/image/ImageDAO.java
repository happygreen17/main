package image;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bbs.BbsDTO;
import db.DBClose;
import db.DBOpen;

public class ImageDAO {
	public boolean create(ImageDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into imgbbs(id, num, mname, title, content, wdate, fname, filesize) ");
		sql.append(" values(?, (select nvl(max(num), 0) + 1 as num from imgbbs),  ");
		sql.append(" ?, ?, ?, sysdate, ?, ?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFname());
			pstmt.setInt(6, dto.getFilesize());
			
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

	
	
	public boolean update(ImageDTO dto) {
		boolean flag = false;
		
		Map<String, String> map = new HashMap<String, String>();
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update imgbbs ");
		sql.append(" set title=?, content=?, fname=?, filesize=? ");
		sql.append(" where num = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFname());
			pstmt.setInt(4, dto.getFilesize());
			pstmt.setInt(5, dto.getNum());
			
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

	public boolean delete(int num) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from imgbbs  ");
		sql.append(" where num = ?  ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			
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

	public List<ImageDTO> list(Map map) {
		List<ImageDTO> list = new ArrayList<ImageDTO>();
		
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select id, num, mname, title, content, wdate, fname, viewcnt, filesize, r ");
		sql.append(" from( ");
		sql.append(" 	select id, num, mname, title, content, wdate, fname, viewcnt, filesize, rownum r ");
		sql.append(" 	from( ");
		sql.append(" 		select id, num, mname, title, content, to_char(wdate, 'yyyy-MM-dd') wdate, fname, viewcnt, filesize ");
		sql.append(" 		from imgbbs ");
		if(word.trim().length() > 0) {
			sql.append(" 	where " + col + " like '%'||?||'%'");
		}
		sql.append(" 		order by num desc ");
		sql.append(" 		) ");
		sql.append(" ) ");
		sql.append(" where r >= ? and r <= ? ");
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ImageDTO dto = new ImageDTO();
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setMname(rs.getString("mname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setFilesize(rs.getInt("filesize"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public List<ImageDTO> list(){
		List<ImageDTO> list = new ArrayList<ImageDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT id, num, title, viewcnt, wdate, r ");
		sql.append("from( ");
		sql.append("	SELECT id, num, title, viewcnt, wdate, rownum r ");
		sql.append("	from( ");
		sql.append(" 		SELECT id, num, title, viewcnt, to_char(wdate, 'yyyy-MM-dd') wdate ");
		sql.append(" 		FROM imgbbs ");
		sql.append(" 		order by num desc ");
		sql.append(" 		) ");
		sql.append(" 	) ");
		sql.append(" where r >= 1 and r <= 5 ");
		 
		try {
		pstmt = con.prepareStatement(sql.toString());
		 
		rs = pstmt.executeQuery();
		 
		while(rs.next()) {
			ImageDTO dto = new ImageDTO();
			dto.setId(rs.getString("id"));
			dto.setNum(rs.getInt("num"));
			dto.setTitle(rs.getString("title"));
			dto.setWdate(rs.getString("wdate"));
			dto.setViewcnt(rs.getInt("viewcnt"));
			
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
	
	public int total(Map map) {
		int totalRecord = 0;
		
		String word = (String)map.get("word");
		String col = (String)map.get("col");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) ");
		sql.append(" from imgbbs ");
		if(word.trim().length() > 0) {
			sql.append(" where " + col + " like '%'||?||'%' ");
		}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length() > 0) {
				pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalRecord = rs.getInt("count(*)");
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}	
		
		return totalRecord;
	}

	public List imgRead(int num){ 	//나, 앞의 2개, 뒤의 2개 행을 읽어오는 역할
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(num,2)     over (order by num) pre_num2,    ");
		sql.append("          lag(num,1)     over (order by num ) pre_num1,   ");
		sql.append("          num,  ");
		sql.append("          lead(num,1)    over (order by num) nex_num1,    ");
		sql.append("          lead(num,2)    over (order by num) nex_num2,    ");
		sql.append("          lag(fname,2)  over (order by num) pre_file2,     ");
		sql.append("          lag(fname,1)  over (order by num ) pre_file1,  ");
		sql.append("          fname,   ");
		sql.append("          lead(fname,1) over (order by num) nex_file1,  ");
		sql.append("          lead(fname,2) over (order by num) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT num, fname   ");
		sql.append("               FROM imgbbs ");
		sql.append("               ORDER BY num DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE num = ? ");	
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_num2"),
						rs.getInt("pre_num1"),
						rs.getInt("num"),
						rs.getInt("nex_num1"),
						rs.getInt("nex_num2")
					    };
				//System.out.println(rs.getInt("pre_num2"));
				//rs.rs.getString("pre_file2") 값이 null이면 0이 나온다고 한다.
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("fname"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(con, pstmt, rs);
		}
				
		return list;
	}
	
	public ImageDTO read(int num) {	
		ImageDTO dto = new ImageDTO();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select id, num, mname, title, content, to_char(wdate, 'yyyy-MM-dd') wdate, fname, viewcnt, filesize ");
		sql.append(" from imgbbs ");
		sql.append(" where num = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setMname(rs.getString("mname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setFilesize(rs.getInt("filesize"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}	
		
		return dto;
	}
	
	public void upViewcnt(int num) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update imgbbs ");
		sql.append(" set viewcnt = viewcnt + 1 ");
		sql.append(" where num = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			
			int cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}		
	}
}
