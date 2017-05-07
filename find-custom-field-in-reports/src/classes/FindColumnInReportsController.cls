/*
* Copyright (c) 2017, sfofthings.com
* This Class controller is used to Find a column name particularly custom fields used 
* in which report
*
*/
public class FindColumnInReportsController {

    public string findColumnName { get; set;}

    public List<Report> reportList { get; set;}

    public void ClearForm() {  
        if (reportList != null) {
            reportList.clear();  
        }
    }  


    // Get the Report Metadata information based on ReportId
    public Reports.ReportMetadata GetReportMetadata(string reportId) {
        Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);

        Reports.ReportMetadata resMetaData = describe.getReportMetadata();
        System.debug(resMetaData);
        return resMetaData;
    }


    // Get Report Columns
    public List<String> GetReportColumns(string reportId) {
        List<String> columnsStr = new List<String>();

        if (reportId != null) {
            
            columnsStr = GetReportMetadata(reportId).getDetailColumns();
            system.debug('Columns returned ' + columnsStr);
        }
        return columnsStr;
    }


    // Main Method entry
    @Auraenabled
    public void GetReports () {
        List<Report> reportResult = [SELECT Id, DeveloperName, Name, LastRunDate, Description, IsDeleted, FolderName FROM Report];
        
        reportList = new List<Report>();
        
        // Loop through each report
        for(Report rpt:reportResult){
            string reportId = (String)rpt.Id;
           
            List<String> columnsStr = GetReportColumns(reportId);
			System.debug('setColumns=======' + columnsStr);
            
            for(String str: columnsStr) {
            	if (str.containsIgnoreCase(findColumnName) )
             	{                
                	reportList.add(rpt);
                    System.debug('report being added ' + rpt);
                    break;
             	}
            }             
        }
        System.debug('Total Reports found:' + reportList.size());
        
    }

}