pageextension 51512181 "CustomersExt" extends "Customer List"
{

    /*     views
        {
            addfirst
            {
                view(AddFromVSC)
                {
               /*    Caption = 'Add From Visual Studio Code';
                  Filters=where(ISNormalMember=filter(false)); 
                }

            }

        } */
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetRange(Rec.ISNormalMember, false);
    end;
}