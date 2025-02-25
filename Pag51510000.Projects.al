page 51510000 "Projects"
{
    CardPageID = "Projects Card";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Projects;



    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Name; Rec.Name)
                {
                }
                field("No of Plots"; Rec."No of Plots")
                {
                }
                field("Plot Size"; Rec."Plot Size")
                {
                }

            }
        }
    }

    actions
    {
    }
}

