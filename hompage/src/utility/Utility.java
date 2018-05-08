package utility;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Utility {
	
	public static String getCodeValue(String code) {
		String value=null;
		
		Map<String, String> codes = new HashMap<String, String>();
		codes.put("A01", "회사원");
		codes.put("A02", "전산관련직");
		codes.put("A03", "연구전문직");
		codes.put("A04", "각종학교학생");
		codes.put("A05", "일반자영업");
		codes.put("A06", "공무원");
		codes.put("A07", "의료인");
		codes.put("A08", "법조인");
		codes.put("A09", "종교/언론/예술인");
		codes.put("A010", "기타");
		
		value=codes.get(code);
		
		return value;
	}

	public static List<String> getDay() {
		List<String> list = new ArrayList<String>();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance(); // Calendar 는 추상클래스이기 때문에 따로 getInstance()로 객체를 받아와야 한다. (new 안됨)
		for (int j = 0; j < 3; j++) {
			list.add(sd.format(cal.getTime())); // getTime: 오늘날짜를 sd 형식으로 list에 넣어준다
			cal.add(Calendar.DATE, -1); // cal 변수에.... 오늘날짜에서 -1(어제날짜)로 바꿔 넣어줌
		} // 결과적으로 어제 그제 오늘날짜가 list 에 저장된다. 이를 반환
		return list;
	}

	public static boolean compareDay(String wdate) {

		boolean flag = false;
		List<String> list = getDay(); // 위에 우리가 만든 메소드 getDay()호출, list 로 받아옴
		if (wdate.equals(list.get(0)) || wdate.equals(list.get(1)) || wdate.equals(list.get(2))) {
			flag = true;
		}
		return flag; // list 에 어제 그제 오늘날짜와 받아온 wdate와 값이 같다면 flag를 true, 아니면 false 반환
	}

	public static String paging3(int totalRecord, int nowPage, int recordPerPage, String col, String word) {
		// 이 값들을 jsp 에서 받아와야 한다.

		int pagePerBlock = 10; // 블럭당 페이지 수 (ex 11부터 20까지 10개)
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage)); // 전체 페이지
		// ceil : 올림(10보다 작을 경우 페이지가 안보일 수 도 있으므로 ..꼭 올려준다)
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		// 올리는 이유 : 15에서 끊어질 수 있기 때문.
		int nowGrp = (int) (Math.ceil((double) nowPage / pagePerBlock)); // 현재 그룹 //현재페이지번호가 15라면 그룹번호는 2

		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작 (아래에 나타나는 페이지 버튼의 수)
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료

		StringBuffer str = new StringBuffer();

		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("  .span_box_1{");
		str.append("    text-align: center;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		// span_box_2 : 현재 내 페이지임을 표시하는 것. 배경이 생긴다
		str.append("  .span_box_2{");
		str.append("    text-align: center;");
		str.append("    background-color: #668db4;");
		str.append("    color: #FFFFFF;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		// str.append("현재 페이지: " + nowPage + " / " + totalPage + " ");

		/*
		 * 총 페이지 : 30 1 2 3 4 5 6 7 8 9 10 [다음] - 1그룸 [이전]11 12 13 14 15 16 17 18 19 20
		 * [다음] - 2그룹
		 */

		int _nowPage = (nowGrp - 1) * pagePerBlock; // 현재페이지가 11이면 [이전]을 눌렀을 시 10페이지로 이동
		if (nowGrp >= 2) { // [이전]이 보이려면 2번째 그룹 이상일때이어야 한다. (첫번째 그룹에서는 이전할 수가 없으므로 뺌)
			str.append("<span class='span_box_1'><A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage="
					+ _nowPage + "'>이전</A></span>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				// 그룹의 페이지 끝번호(ex 20)만큼 반복하는데 전체 페이지 번호(ex 18)가 이보다 작을 수 있으므로 빠져나오는 if 문을
				// 만들어주었다.
				break;
			}

			if (nowPage == i) { // 현재 보여주고 있는 페이지와 출력하고 있는 페이지가 같을 때 아래 span에 배경색 표시
				str.append("<span class='span_box_2'>" + i + "</span>");
			} else {
				str.append("<span class='span_box_1'><A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + i
						+ "'>" + i + "</A></span>");
			}
		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 현재페이지가 8이면 [다음]을 눌렀을 시 11페이지로 이동
		if (nowGrp < totalGrp) { // 다음으로 갈 수 있을때만 보여준다
			str.append("<span class='span_box_1'><A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage="
					+ _nowPage + "'>다음</A></span>");
		}
		str.append("</DIV>");

		return str.toString();
	}
	
	
	
	
	
	
	public static String paging(int totalRecord, int nowPage, int recordPerPage) {
		// 이 값들을 jsp 에서 받아와야 한다.

		int pagePerBlock = 10; // 블럭당 페이지 수 (ex 11부터 20까지 10개)
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage)); // 전체 페이지
		// ceil : 올림(10보다 작을 경우 페이지가 안보일 수 도 있으므로 ..꼭 올려준다)
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		// 올리는 이유 : 15에서 끊어질 수 있기 때문.
		int nowGrp = (int) (Math.ceil((double) nowPage / pagePerBlock)); // 현재 그룹 //현재페이지번호가 15라면 그룹번호는 2

		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작 (아래에 나타나는 페이지 버튼의 수)
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료

		StringBuffer str = new StringBuffer();

		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("  .span_box_1{");
		str.append("    text-align: center;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		// span_box_2 : 현재 내 페이지임을 표시하는 것. 배경이 생긴다
		str.append("  .span_box_2{");
		str.append("    text-align: center;");
		str.append("    background-color: #668db4;");
		str.append("    color: #FFFFFF;");
		str.append("    font-size: 1em;");
		str.append("    border: 1px;");
		str.append("    border-style: solid;");
		str.append("    border-color: #cccccc;");
		str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
		str.append("  }");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		// str.append("현재 페이지: " + nowPage + " / " + totalPage + " ");

		/*
		 * 총 페이지 : 30 1 2 3 4 5 6 7 8 9 10 [다음] - 1그룸 [이전]11 12 13 14 15 16 17 18 19 20
		 * [다음] - 2그룹
		 */

		int _nowPage = (nowGrp - 1) * pagePerBlock; // 현재페이지가 11이면 [이전]을 눌렀을 시 10페이지로 이동
		if (nowGrp >= 2) { // [이전]이 보이려면 2번째 그룹 이상일때이어야 한다. (첫번째 그룹에서는 이전할 수가 없으므로 뺌)
			str.append("<span class='span_box_1'><A href='./list.jsp?&nowPage="
					+ _nowPage + "'>이전</A></span>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				// 그룹의 페이지 끝번호(ex 20)만큼 반복하는데 전체 페이지 번호(ex 18)가 이보다 작을 수 있으므로 빠져나오는 if 문을
				// 만들어주었다.
				break;
			}

			if (nowPage == i) { // 현재 보여주고 있는 페이지와 출력하고 있는 페이지가 같을 때 아래 span에 배경색 표시
				str.append("<span class='span_box_2'>" + i + "</span>");
			} else {
				str.append("<span class='span_box_1'><A href='./list.jsp?&nowPage=" + i
						+ "'>" + i + "</A></span>");
			}
		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 현재페이지가 8이면 [다음]을 눌렀을 시 11페이지로 이동
		if (nowGrp < totalGrp) { // 다음으로 갈 수 있을때만 보여준다
			str.append("<span class='span_box_1'><A href='./list.jsp?&nowPage="
					+ _nowPage + "'>다음</A></span>");
		}
		str.append("</DIV>");

		return str.toString();
	}
	
	
	
	
	

	/**
	 * 숫자 형태의 페이징, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17 18 19 20
	 * [다음]
	 * 
	 * @param totalRecord
	 *            전체 레코드수
	 * @param nowPage
	 *            현재 페이지
	 * @param recordPerPage
	 *            페이지당 출력할 레코드 수
	 * @param col
	 *            검색 컬럼
	 * @param word
	 *            검색어
	 * @return 페이징 생성 문자열
	 */
	public static String paging(int totalRecord, int nowPage, int recordPerPage, String col, String word) {
		int pagePerBlock = 10; // 블럭당 페이지 수
		int totalPage = (int) (Math.ceil((double) totalRecord / recordPerPage));// 전체 페이지
		int totalGrp = (int) (Math.ceil((double) totalPage / pagePerBlock));// 전체 그룹
		int nowGrp = (int) (Math.ceil((double) nowPage / pagePerBlock)); // 현재 그룹
		int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작
		int endPage = (nowGrp * pagePerBlock); // 특정 그룹의 페이지 목록 종료

		StringBuffer str = new StringBuffer();

		str.append("<style type='text/css'>");
		str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
		str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
		str.append(
				"  #paging A:hover{text-decoration:underline; background-color: #ffffff; color:black; font-size: 1em;}");
		str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
		str.append("</style>");
		str.append("<DIV id='paging'>");
		str.append("현재 페이지: " + nowPage + " / " + totalPage + "  ");

		int _nowPage = (nowGrp - 1) * pagePerBlock; // 10개 이전 페이지로 이동
		if (nowGrp >= 2) {
			str.append("[<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + _nowPage + "'>이전</A>]");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}

			if (nowPage == i) { // 현재 페이지이면 강조 효과
				str.append("<span style='font-size: 1.2em; font-weight: bold;'>" + i + "</span> ");
			} else {
				str.append("<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + i + "'>" + i + "</A> ");
			}

		}

		_nowPage = (nowGrp * pagePerBlock) + 1; // 10개 다음 페이지로 이동
		if (nowGrp < totalGrp) {
			str.append("[<A href='./list.jsp?col=" + col + "&word=" + word + "&nowPage=" + _nowPage + "'>다음</A>]");
		}
		str.append("</DIV>");

		return str.toString();
	}

	public static String checkNull(String str) {
		if (str == null) {
			str = "";
		}

		return str.trim();
	}
}
