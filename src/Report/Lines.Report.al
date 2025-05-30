report 50400 "AMM Report Sales Lines"
{
    Caption = 'Report Sales Lines';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'layout/SalesLinesRDL.rdl';
    dataset
    {
        dataitem("AMM Import Buffer";"AMM Import Buffer")
        {
            column(Batch_Name;"Batch Name"){}
            column(Line_No_;"Line No."){}
            column(Document_Type;"Document Type"){}
            column(Document_No_;"Document No."){}
            column(Sell_to_Customer_No_;"Sell-to Customer No."){}
            column(Type;Type){}
            column(Unit_Price;"Unit Price"){}
            column(No_;"No."){}
            column(Description;Description){}
            column(Quantity;Quantity){}
            column(Amount;Amount){}
            column(File_Name;"File Name"){}
            column(Sheet_Name;"Sheet Name"){}
            column(Imported_Date;"Imported Date"){}
            column(Imported_Time;"Imported Time"){}
            column(CampoCalculado;CampoCalculado){}
        }
    }
}