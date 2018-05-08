package member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.org.apache.bcel.internal.generic.DASTORE;

public class MemberTest {

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		//duplicateId(dao);
		//duplicateEmail(dao);
		//create(dao);
		//list(dao);
		//total(dao);
		//read(dao);
		//update(dao);
		//getFname(dao);
		//loginCheck(dao);
		getGrade(dao);

	}


	private static void getGrade(MemberDAO dao) {
		String grade = dao.getGrade("user1");
		p(grade);		
	}


	private static void loginCheck(MemberDAO dao) {
		Map map = new HashMap();
		map.put("id", "user1");
		map.put("passwd", "1234");
		
		if(dao.loginCheck(map)) {
			p("회원입니다");
		}else {
			p("회원이 아닙니다.");
		}	
	}

	private static void getFname(MemberDAO dao) {
		String fname = dao.getFname("user1");
		p(fname);
	}

	private static void update(MemberDAO dao) {
		MemberDTO dto = dao.read("user1");
		
		dto.setTel("000-0000-0000");
		dto.setZipcode("00000");
		dto.setAddress1("안드로메다");
		dto.setAddress2("은하002-03");
		dto.setEmail("user1@mail.com");
		dto.setJob("A10");
		
		if(dao.update(dto)) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void read(MemberDAO dao) {
		MemberDTO dto = dao.read("user1");
	
		p(dto);	
	}

	private static void total(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word", "홍");
		
		p("레코드 갯수: "+dao.total(map));
		
	}

	private static void list(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word", "");
		map.put("sno", 1);
		map.put("eno", 5);
		
		List<MemberDTO> list = dao.list(map);
		
		for(int i =0; i < list.size(); i++) {
			MemberDTO dto = list.get(i);
			p(dto);
			p("------------------------------");
		}
	}

	private static void p(MemberDTO dto) {
		p("아이디: "+ dto.getId());
		p("이름: "+ dto.getMname());
		p("전화번호: "+ dto.getTel());
		p("이메일: "+ dto.getEmail());
		p("우편번호: "+ dto.getZipcode());
		p("주소: "+ dto.getAddress1());
		p("상세주소: "+ dto.getAddress2());
		p("직업: "+ dto.getJob());
		p("사진: "+ dto.getFname());
		p("가입날짜: "+ dto.getMdate());

	}

	private static void create(MemberDAO dao) {
		MemberDTO dto = new MemberDTO();
		dto.setId("test2");
		dto.setPasswd("1234");
		dto.setTel("010-1111-1111");
		dto.setEmail("test2@mail.com");
		dto.setMname("홍길동");
		dto.setZipcode("00000");
		dto.setAddress1("서울시 종로구 관철동");
		dto.setAddress2("13-13");
		dto.setJob("A01");
		dto.setFname("aaa.jpg");
		
		if(dao.create(dto)) {
			p("성공");
		}else {
			p("실패");
		}
		
	}

	private static void duplicateEmail(MemberDAO dao) {
		String email = "email1@mail.com";
		if(dao.duplicateEmail(email)) {
			p("중복");
		}else {
			p("사용가능");
		}	
		
	}

	private static void duplicateId(MemberDAO dao) {
		String id = "user77";
		
		if(dao.duplicateId(id)) {
			p("중복");
		}else {
			p("사용가능");
		}	
	}

	private static void p(String string) {
		System.out.println(string);
	}
}
