pageextension 50401 "AMM Email" extends "AMM Import Worksheet"  
{
    actions
    {
        addfirst(Creation){
            action("Enviar Email")
            {
                Caption = 'Enviar Email';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendEmailPDF;
                ToolTip = 'Envia un email a varios destinatarios con un PDF';

                trigger OnAction()
                var
                    CodeunitEmail: Codeunit "AMM Enviar Email";
                begin
                    CodeunitEmail.EnviarEmail();
                end;
            }
        }
    }
}