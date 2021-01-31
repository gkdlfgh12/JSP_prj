package util;

import evaluation.EvaluationDAO;

//������ �˰��� ���� ����, ���� ��ư �� ������ ��ư ���� �� ��ȣ�� ������ ��ü.
public class PageCreator {
	
	//������ ��ȣ�� �� �������� �� �Խù��� ������ ���� �ִ� ��ü
	private int pageNum;
	private int articleTotalCount; //�Խ����� �� �Խù� ��
	private int beginPage; //���� ������ ��ȣ
	private int endPage; //�� ������ ��ȣ
	private boolean prev; //���� ��ư Ȱ��ȭ ����
	private boolean next; //���� ��ư Ȱ��ȭ ����
	
	EvaluationDAO evalDAO = new EvaluationDAO();
	
	//�� ȭ�鿡 ������ ������ ��ư ��
	private final int displayPageNum = 5;
	
	//����¡ �˰����� ������ �޼��� ����.
	private void calcDataOfPage() {
		
		//���� �� �� ������ ���ϱ�
		endPage = (int) (Math.ceil(pageNum / (double)displayPageNum) 
				* displayPageNum);
		
		//���� ������ ��ȣ ���ϱ�
		beginPage = (endPage - displayPageNum) + 1;
		
		//���� ���� �������� 1�̶�� ���� ��ư Ȱ��ȭ ���θ� false�� ����.
		prev = (beginPage == 1) ? false : true;
		
		//������ ���������� ���� Ȯ�� �� ���� ��ư ��Ȱ��ȭ �Ǵ�.
		next = (articleTotalCount <= (endPage * 5)) ? false : true;
		
		//���� ��ư�� ��Ȱ��ȭ��� �� ������ �纸�� �ϱ�.
		if(!isNext()) {
			endPage = (int) Math.ceil(articleTotalCount / (double)5); 
		}
		
	}
	
	
	

	

	

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) { //page ��ȣ �־������
		this.pageNum = pageNum;
	}

	public int getArticleTotalCount() { 
		return articleTotalCount;
	}

	public void setArticleTotalCount(String keyword, String lectureDivide) {// ���� �־�� �ǰ�
		System.out.println("���� pc�� set "+keyword + "--"+ lectureDivide);
		//��ġ���� ���� ���� Ȯ�� �Լ�
		int count = evalDAO.getTotalCount(keyword, lectureDivide);
		
		this.articleTotalCount = count;
		calcDataOfPage();
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) { 
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
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


	@Override
	public String toString() {
		return "PageCreator [pageNum=" + pageNum + ", articleTotalCount=" + articleTotalCount + ", beginPage=" + beginPage
				+ ", endPage=" + endPage + ", prev=" + prev + ", next=" + next + "]";
	}
	
	
	

}
