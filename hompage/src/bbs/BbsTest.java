package bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BbsTest {

	public static void main(String[] args) {
		// DAO가 잘 작동하는지 확인하려는 용도 BEANS TEST
		
		BbsDAO dao = new BbsDAO();
		
		//list(dao);
		//create(dao);
		//read(dao);
		//update(dao);
		//delete(dao);
		//upViewcnt(dao);
		//passCheck(dao);
		total(dao);
		
	}

	private static void total(BbsDAO dao) {
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "김");
		
		int total = dao.total(map);
		
		p("레코드 갯수:" + total);
		
	}

	private static void passCheck(BbsDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("bbsno", 3);
		map.put("passwd", "1234");
		
		if(dao.passCheck(map)) {
			p("올바른 비번입니다.");
		} else {
			p("잘못된 비번입니다.");
		}
		
	}

	private static void upViewcnt(BbsDAO dao) {
		// TODO Auto-generated method stub
		BbsDTO dto = dao.read(2);
		p("조회수: " + dto.getViewcnt());
		p("조회수 증가합니다.");
		dao.upViewcnt(2);
		dto=dao.read(2);
		p("변경된 조회수: " + dto.getViewcnt());
			
	}

	private static void delete(BbsDAO dao) {
		// TODO Auto-generated method stub
		int bbsno = 5;
		
		if (dao.delete(bbsno)) {
			p("삭제 성공");
		} else {
			p("삭제 실패");
		}
		
	}

	private static void update(BbsDAO dao) {
		// TODO Auto-generated method stub
		BbsDTO dto = dao.read(2);
		
		dto.setWname("공룡");
		dto.setTitle("티라노사우르스");
		dto.setContent("가자 사냥!");
		dto.setBbsno(2);
		
		if (dao.update(dto)) {
			p("수정 성공");
		} else {
			p("수정 실패");
		}
	}

	private static void read(BbsDAO dao) {
		// TODO Auto-generated method stub
		int bbsno = 5;
		
		BbsDTO dto = dao.read(bbsno);		
		
		p(dto);
	}

	private static void create(BbsDAO dao) {
		// TODO Auto-generated method stub
		BbsDTO dto = new BbsDTO();
		dto.setWname("아톰");
		dto.setTitle("게시판 연습");
		dto.setContent("게시판의 DB처리 실습");
		dto.setPasswd("123");
		
		if(dao.create(dto)) {
			p("새 글이 등록되었습니다.");
		} else {
			p("새 글 등록이 실패했습니다.");
		}
		
	}

	private static void list(BbsDAO dao) {
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "아로");
		map.put("sno", 1);
		map.put("eno", 5);
		
		List<BbsDTO> list = dao.list(map);
		for (int i=0; i<list.size(); i++) {
			BbsDTO dto = list.get(i);
			p(dto);
			p("------------------------------");
		}
	}


	private static void p(String string) {
		// TODO Auto-generated method stub
		System.out.println(string);
	}

	private static void p(BbsDTO dto) {
		// TODO Auto-generated method stub
		p("번호: " + dto.getBbsno());
		p("제목 : " + dto.getTitle());
		p("내용 : " + dto.getContent());
		p("등록날짜 : " + dto.getWdate());
		p("조회수 :" + dto.getViewcnt());
		p("비밀번호: " + dto.getPasswd());
		p("작성자 : " + dto.getWname());
		p("grpno : " + dto.getGrpno());
		p("ansnum : " + dto.getAnsnum());
		p("indent : " + dto.getIndent());
		
	}
}