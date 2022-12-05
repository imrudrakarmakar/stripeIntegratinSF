// Mapping paarameter does is any time making a call to this url, then the request will come to this Apex Class
@RestResource(urlMapping='/studentsInfo/*')
global class StudentInformationService {
    // All the fields that want to send back in response
    global class StudentInfo {
        String studentName{get;set;}
        String studentAddress{get;set;}
        String studentPhone{get;set;}
        String schoolName{get;set;}
    }
    
	@httpGet
    global static StudentInfo getStudent() {
        RestRequest request = RestContext.Request;
        String studentId = request.requestURI.substring(request.RequestURI.lastIndexOf('/')+1);
        
        Student__c student = [select id,Name,Address__c,Student_Name__c,Phone_Number__c,School__r.Name from Student__c where id=:studentId ];
        StudentInfo stdInfo = new StudentInfo();
        stdInfo.studentName = student.Student_Name__c;
        stdInfo.studentAddress = student.Address__c;
        stdInfo.studentPhone = student.Phone_Number__c;
        stdInfo.schoolName = student.school__r.Name;
        
        return stdInfo;
    }
}