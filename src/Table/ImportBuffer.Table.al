table 50400 "AMM Import Buffer"
{
    Caption = 'SO Import Buffer';
    fields
    {
        field(1; "Batch Name"; Code[10])
        {
            Caption = 'Batch Name';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "File Name"; Text[100])
        {
            Caption = 'File Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Sheet Name"; Text[100])
        {
            Caption = 'Sheet Name';
            DataClassification = CustomerContent;
        }
        field(5; "Imported Date"; Date)
        {
            Caption = 'Imported Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Imported Time"; Time)
        {
            Caption = 'Imported Time';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(9; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(10; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(11; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            DataClassification = CustomerContent;
        }
        field(12; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(16; CampoCalculado; Decimal)
        {
            Caption = 'CampoCalculado';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Batch Name", "Line No.")
        {
        }
    }
}