codeunit 50400 "AMM Cambio Campos"
{
    procedure CampoCalculado(var Amount: Decimal) : Decimal
    begin
        Amount := Amount * 2;
        exit(Amount)
    end;
}