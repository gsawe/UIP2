page 51510002 "Projects Part"
{
    CardPageID = "Projects Card";
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = Projects;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Name; Rec.Name)
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = false;
                }
                field(Size; Rec.Size)
                {
                }
                field("No of Plots"; Rec."No of Plots")
                {
                }
                field("Plot Size"; Rec."Plot Size")
                {
                }
                field("Title No"; Rec."Title No")
                {
                }


            }
        }
    }

    actions
    {
    }
}

