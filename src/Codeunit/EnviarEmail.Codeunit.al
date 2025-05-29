codeunit 50401 "AMM Enviar Email"
{   
    procedure EnviarEmail()
    var
        EmailItem: Record "Email Item";
        ReportExample: Report "AMM Report Sales Lines";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        InStr2: InStream;
        OutStr2: OutStream;
        ReportParameters: Text;
        MailBodyMsg: Label '<body><p>Dear %1:</p><p> You will find the details of the operation in the attached document.</p><p>You can contact us with any questions or in case of error.</p><p>Greetings.</p></body>', Comment = '%1 -To name'; 
    begin
        clear(TempBlob);
        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"AMM Report Sales Lines", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        EmailItem."Send to" := 'admin@CRMbc799147.onmicrosoft.com';
        EmailItem.Subject := 'Probando envío de Email';
        EmailItem.Body.CreateOutStream(OutStr2);
        OutStr2.Write(MailBodyMsg);
        EmailItem.Body.CreateInStream(InStr2);
        EmailItem.AddAttachment(InStr,'AMM_Report_Sales_Lines.pdf');
        EmailItem.Send(true, Enum::"Email Scenario"::Default);
    end;
}