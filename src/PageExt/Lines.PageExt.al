pageextension 50400 "AMM Excel Buffer" extends "Sales Lines"
{
    actions
    {
        addafter("&Line")
        {
            action(ExportToExcel)
            {
                Caption = 'Export to Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                ToolTip = 'Exportar a Excel';

                trigger OnAction()
                begin
                    ExportCustLedgerEntries(Rec);
                end;
            }
        }
    }
    local procedure ExportCustLedgerEntries(var Lines: Record "Sales Line")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CalcularCampo: Codeunit "AMM Cambio Campos";
        CustLedgerEntriesLbl: Label 'Sales Lines';
        ExcelFileName: Label 'SalesLines_%1_%2';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Lines.FieldCaption("Document Type"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption("Document No."),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption("Sell-to Customer No."),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption("Type"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption("Unit Price"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption("No."),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption(Description),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Lines.FieldCaption(Quantity),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Lines.FieldCaption(Amount),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('CampoCalculado',false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Number);
        if Lines.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(Lines."Document Type",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines."Document No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines."Sell-to Customer No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines."Type",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines."Unit Price",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines."No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines.Description,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Lines.Quantity,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(Lines.Amount,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CalcularCampo.CampoCalculado(Lines.Amount),false,'',true,false,false,'',TempExcelBuffer."Cell Type"::Number);
            until Lines.Next() = 0;
            TempExcelBuffer.CreateNewBook(CustLedgerEntriesLbl);
            TempExcelBuffer.WriteSheet(CustLedgerEntriesLbl, CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
            TempExcelBuffer.OpenExcel();
    end;
}