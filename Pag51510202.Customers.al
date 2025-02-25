page 51510202 "Customers"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customers';
    CardPageID = "Customers Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer,Navigate';
    QueryCategory = 'Customer List';
    RefreshOnActivate = true;
    SourceTable = Customer;
    SourceTableView = ORDER(Descending) where(ISNormalMember = const(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer. You can enter a maximum of 50 characters, both numbers and letters.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Visible = false;
                }
                field("ID NO"; Rec."ID NO")
                {
                    Visible = false;
                }
                field("Employee Id"; Rec."Employee Id")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies an alternate name that you can use to search for a customer.';
                    Visible = true;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    Visible = false;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    Caption = 'Deposit Contribution';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    Caption = 'Share Capital';

                }
                field("Xmas Contribution"; Rec."Xmas Contribution")
                {
                    Caption = 'Outstanding Balance';

                }




            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Member List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Member List';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                ToolTip = 'View member list.';

                trigger OnAction()
                begin
                    Report.Run(REPORT::"Member List Report");
                end;
            }
        }
    }









    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        PowerBIVisible: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        EventFilter: Text;
        CaptionTxt: Text;
        UserSetup: Record "User Setup";



    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
          WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, EventFilter);
    end;

    [IntegrationEvent(false, false)]
    procedure SetCaption(var InText: Text)
    begin
    end;
}

