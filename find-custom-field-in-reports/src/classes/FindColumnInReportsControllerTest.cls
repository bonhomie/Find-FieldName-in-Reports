@isTest(SeeAllData=true)
private class FindColumnInReportsControllerTest {
	
	@isTest static void test_GetReports() {

		FindColumnInReportsController findColumnCtrl = new FindColumnInReportsController();
		findColumnCtrl.findColumnName = 'Name';

		findColumnCtrl.GetReports();
		System.assert(findColumnCtrl.reportList.size() > 0);
	}
	
	@isTest static void test_ClearFormBeforeGetReports() {
		FindColumnInReportsController findColumnCtrl = new FindColumnInReportsController();

		findColumnCtrl.ClearForm();

		System.debug(findColumnCtrl.reportList);
		System.assert(findColumnCtrl.reportList == null);
	}


	@isTest static void test_ClearFormAfterGetReports() {
		FindColumnInReportsController findColumnCtrl = new FindColumnInReportsController();
		findColumnCtrl.findColumnName = 'Account';

		findColumnCtrl.GetReports();

		findColumnCtrl.ClearForm();

		System.debug(findColumnCtrl.reportList);
		System.assert(findColumnCtrl.reportList.size() == 0);
	}


	@isTest static void test_GetReportColumns() {
		FindColumnInReportsController findColumnCtrl = new FindColumnInReportsController();
		
		List<Report> report = [Select Id from Report LIMIT 1];
		if (report.size() > 0 ) {
			string id = (String)report[0].Id;

			List<String> cols = findColumnCtrl.GetReportColumns(id);
			System.assert(cols.size() > 0);

		}
	}


	// Get Report Metadata
	@isTest static void test_GetReportMetaData() {
		FindColumnInReportsController findColumnCtrl = new FindColumnInReportsController();
		
		Report report = [Select Id from Report LIMIT 1];
		System.assert(report != null);
		if (report != null) {
			string id = (String)report.Id;

			Reports.ReportMetadata metadata = findColumnCtrl.getReportMetaData(id);
			System.assert(metadata != null);


		}
	}

}