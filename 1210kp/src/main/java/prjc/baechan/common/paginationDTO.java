package prjc.baechan.common;


public class paginationDTO{
	
	private int page;			// 현재 페이지
	private int cntPerPage;		// 페이지당 보여줄 리스트 개수
	private int cntPage;		// 보여지는 페이지목록의 개수
	
	private int totalPage;		// 전체 페이지 수
	private int total;			// 전체 리스트 수
	private int startIdx;		// 페이지별 리스트 시작 index
	
	private int startPage;		// 보여지는 페이지목록의 시작페이지
	private int endPage;		// 보여지는 페이지목록의 끝페이지
	private boolean prev;		// 이전 페이지 버튼
	private boolean next;		// 다음 페이지 버튼
	
	private String keyword="";
	private String option="";
	
	
	public paginationDTO() {
		this.page = 1;
		this.cntPerPage = 10;
		this.cntPage = 5;
		
	}
	
	@Override
	public String toString() {
		return "paginationDTO [page=" + page + ", " + "cntPerPage=" + cntPerPage + "]";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		
		if(page <= 0) {
			this.page = 1;
		}else {
			this.page = page;
		}
		return;
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public void setCntPerPage(int cntPerPage) {
		
		if(cntPerPage <=0 || cntPerPage > 100) {
			this.cntPerPage = 10;
		}else {
			this.cntPerPage = cntPerPage;
		}
		return;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
				
		totalPage = (int) Math.ceil((double)total / cntPerPage);
		
		if(page <= cntPage) {
			endPage = (int) Math.ceil((double)page / cntPage) * cntPage;
			startPage = (endPage - cntPage) + 1;
		}else if(totalPage - page + 1 <= cntPage){
			endPage = totalPage;
			startPage = (endPage - cntPage) + 1;
		}else {
			endPage = page + 2;
			if(startPage < totalPage - cntPage){
				startPage = page - 2;
			}
		}
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		if(startPage < 1) {
			startPage = 1;
		}
			
		prev = page == startPage ? false : true;
		next = page == totalPage ? false : true;
		
		setEndPage(endPage);
		setStartPage(startPage);
		setTotalPage(totalPage);
		
		setPrev(prev);
		setNext(next);
	}

	public int getTotalPage() {	
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCntPage() {
		return cntPage;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

	public int getStartIdx() {
		return (page - 1) * cntPerPage;

	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	
	
	
}