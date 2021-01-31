package evaluation;

public class EvaluationVO {
	int evaluationID;  //강의 평가 id
	String userID; 
	String lectureName;  //강의명
	String professorName;
	int lectureYear;  //수강연도
	String semesterDivide;   //학기 구분
	String lectureDivide;  //강의 구분
	String evaluationTitle;  //강의평가 제목
	String evaluationContent; //강의펴가 내용
	String totalScore;
	String creditScore;   //성적
	String interestScore; //흥미도 평가
	String lectureScore;  //강의력 평가
	int likeCount;
	
	public EvaluationVO() {
	}
	
	public EvaluationVO(int evaluationID, String userID, String lectureName, String professorName, int lectureYear,
			String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent,
			String totalScore, String creditScore, String interestScore, String lectureScore, int likeCount) {
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lectureDivide = lectureDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.creditScore = creditScore;
		this.interestScore = interestScore;
		this.lectureScore = lectureScore;
		this.likeCount = likeCount;
	}




	@Override
	public String toString() {
		return "EvaluationVO [evaluationID=" + evaluationID + ", userID=" + userID + ", lectureName=" + lectureName
				+ ", professorName=" + professorName + ", lectureYear=" + lectureYear + ", semesterDivide="
				+ semesterDivide + ", lectureDivide=" + lectureDivide + ", evaluationTitle=" + evaluationTitle
				+ ", evaluationContent=" + evaluationContent + ", totalScore=" + totalScore + ", creditScore="
				+ creditScore + ", interestScore=" + interestScore + ", lectureScore=" + lectureScore + ", likeCount="
				+ likeCount + "]";
	}



	public int getEvaluationID() {
		return evaluationID;
	}

	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getLectureName() {
		return lectureName;
	}

	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}

	public String getProfessorName() {
		return professorName;
	}

	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}

	public int getLectureYear() {
		return lectureYear;
	}

	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}

	public String getSemesterDivide() {
		return semesterDivide;
	}

	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}

	public String getLectureDivide() {
		return lectureDivide;
	}

	public void setLectureDivide(String lectureDivide) {
		this.lectureDivide = lectureDivide;
	}

	public String getEvaluationTitle() {
		return evaluationTitle;
	}

	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}

	public String getEvaluationContent() {
		return evaluationContent;
	}

	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}

	public String getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}

	public String getCreditScore() {
		return creditScore;
	}

	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}

	public String getInterestScore() {
		return interestScore;
	}

	public void setInterestScore(String interestScore) {
		this.interestScore = interestScore;
	}

	public String getLectureScore() {
		return lectureScore;
	}

	public void setLectureScore(String lectureScore) {
		this.lectureScore = lectureScore;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	
}
