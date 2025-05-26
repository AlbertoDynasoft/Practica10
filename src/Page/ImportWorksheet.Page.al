page 50400 "AMM Import Worksheet"
{
    AutoSplitKey = true;
    Caption = 'SO Import Worksheet';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "AMM Import Buffer";
    SourceTableView = sorting("Batch Name", "Line No.");
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field(BatchName; BatchName)
            {
                Caption = 'Batch Name';
                ApplicationArea = All;
                ToolTip = 'Specifies the "Batch Name"';
            }
            repeater(Group)
            {
                Editable = false;
                field("Batch Name"; Rec."Batch Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Batch Name"';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Line No."';
                }
                field("Document Type";Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Document Type"';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Document No."';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Sell-to Customer No."';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Type"';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Unit Price"';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "No."';
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Description"';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Quantity"';
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Amount"';
                }
                field(CampoCalculado;Rec.CampoCalculado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "CampoCalculado"';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "File Name"';
                }
                field("Sheet Name"; Rec."Sheet Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Sheet Name"';
                }
                field("Imported Date"; Rec."Imported Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Imported Date"';
                }
                field("Imported Time"; Rec."Imported Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the "Imported Time"';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Import")
            {
                Caption = '&Import';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';
                trigger OnAction()
                var
                begin
                    if BatchName = '' then
                        Error(BatchISBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                end;
            }
            action("&Report")
            {
                Caption = '&Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Create Report';
                trigger OnAction()
                var
                begin
                    GenerateReport();
                end;
            }
            action("&Delete")
            {
                Caption = '&Delete';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Delete Lines';
                trigger OnAction()
                var
                    SOImportBuffer: Record "AMM Import Buffer";
                begin
                    SOImportBuffer.DeleteAll();
                end;
            }
        }
    }
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';
    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;
    local procedure ImportExcelData()
    var
        SOImportBuffer: Record "AMM Import Buffer";
        RowNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        Modifica: Boolean;
    begin
        RowNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        SOImportBuffer.Reset();
        if SOImportBuffer.FindFirst() then
            LineNo := SOImportBuffer."Line No."
        else
            LineNo := 10000;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
        for RowNo := 2 to MaxRowNo do begin
            SOImportBuffer.SetRange("Line No.",LineNo);
            if SOImportBuffer.FindFirst() then
                Modifica := True;
            SOImportBuffer.Init();
            Evaluate(SOImportBuffer."Batch Name", BatchName);
            SOImportBuffer."Line No." := LineNo;
            Evaluate(SOImportBuffer."Document Type", GetValueAtCell(RowNo, 1));
            Evaluate(SOImportBuffer."Document No.", GetValueAtCell(RowNo, 2));
            Evaluate(SOImportBuffer."Sell-to Customer No.", GetValueAtCell(RowNo, 3));
            Evaluate(SOImportBuffer.Type, GetValueAtCell(RowNo, 4));
            Evaluate(SOImportBuffer."Unit Price", GetValueAtCell(RowNo, 5));
            Evaluate(SOImportBuffer."No.", GetValueAtCell(RowNo, 6));
            Evaluate(SOImportBuffer.Description, GetValueAtCell(RowNo, 7));
            Evaluate(SOImportBuffer.Quantity, GetValueAtCell(RowNo, 8));
            Evaluate(SOImportBuffer.Amount, GetValueAtCell(RowNo, 9));
            Evaluate(SOImportBuffer.CampoCalculado, GetValueAtCell(RowNo, 10));
            SOImportBuffer."Sheet Name" := SheetName;
            SOImportBuffer."File Name" := FileName;
            SOImportBuffer."Imported Date" := Today;
            SOImportBuffer."Imported Time" := Time;
            if Modifica then
                SOImportBuffer.Modify()
            else
                SOImportBuffer.Insert();
            LineNo := LineNo + 10000;
            Modifica := False;
        end;
        Message(ExcelImportSucess);
    end;
    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;
    local procedure GenerateReport()
    var
        ReportSalesLine: Report "AMM Report Sales Lines";
    begin
        ReportSalesLine.Run();
    end;
}