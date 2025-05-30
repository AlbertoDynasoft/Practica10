page 50401 "Tarjeta información de usuario"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "AMM Datos API";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'General';
                field(ID;Rec.ID)
                {
                    trigger OnValidate()
                    begin
                        GetUserInfo();
                    end;
                }
                field(Nombre;Rec.Nombre)
                {
                    Editable = false;
                }
                field(CorreoElectronico;Rec.CorreoElectronico)
                {
                    Editable = false;
                }
                field(Telefono;Rec.Telefono)
                {
                    Editable = false;
                }
                field(NombreEmpresa;Rec.NombreEmpresa)
                {
                    Editable = false;
                }
            }
        }
    }
    actions{
        area(Creation){
            action("Report Datos API"){
                ToolTip = 'Creación de un report de datos de una API';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DatosAPI: Report "AMM Report Datos API";
                begin
                    DatosAPI.Run();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        GetUserInfo();
    end;
    local procedure GetUserInfo()
    var
        DatosAPI: Record "AMM Datos API";
        Cliente: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Token: JsonToken;
        ValoresArray: JsonToken;
        Array: JsonArray;
        JsonText: Text;
        DireccionURL: Text;
        NumeroElementos: Integer;
        Contador: Integer;
    begin
        DireccionURL := 'https://jsonplaceholder.typicode.com/users/';
        if not Cliente.Get(DireccionURL, responseMessage) then
            Error(ErrorInfo.Create('The call to the web service failed.'));
        if not ResponseMessage.IsSuccessStatusCode then
            Error(ErrorInfo.Create('The web service returned an error message:\\' +
                'Status code: ' + Format(ResponseMessage.HttpStatusCode()) +
                'Description: ' + ResponseMessage.ReasonPhrase()));   
        ResponseMessage.Content.ReadAs(JsonText);
        if not Array.ReadFrom(JsonText) then
            Error(ErrorInfo.Create('Invalid response, expected a JSON object'));
        Contador := 0;
        NumeroElementos := Array.Count();
        DatosAPI.DeleteAll();
        if Array.ReadFrom(JsonText) then
            repeat
                DatosAPI.Init();
                Array.Get(Contador, ValoresArray);
                ValoresArray.AsObject().Get('id', Token);
                DatosAPI.ID := Token.AsValue().AsInteger();
                ValoresArray.AsObject().Get('name', Token);
                DatosAPI.Nombre := Token.AsValue().AsText();
                ValoresArray.AsObject().Get('phone', Token);
                DatosAPI.Telefono := Token.AsValue().AsText();
                ValoresArray.AsObject().Get('email', Token);
                DatosAPI.CorreoElectronico := Token.AsValue().AsText();
                ValoresArray.AsObject().Get('company', Token);
                Token.AsObject().Get('name', Token);
                DatosAPI.NombreEmpresa := Token.AsValue().AsText();
                DatosAPI.Insert();
                Contador := Contador + 1;
            until Contador = NumeroElementos;
    end;
}