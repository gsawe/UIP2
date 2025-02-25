page 51512412 "User Task Cue AU"
{
    Caption = 'Investment Statistics';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";
    Permissions = tabledata "Sales Cue" = rm;

    layout
    {
        area(content)
        {
            cuegroup("Members")
            {
                Caption = 'Members';
                field("Total Members"; Rec."Total Members")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = Customers;
                    ToolTip = 'Specifies the number of members.';
                    Image = none;
                }
                field("Male Members"; Rec."Male Members")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = Customers;
                    ToolTip = 'Specifies the number of male members';
                    Image = none;
                }

                field("Female Members"; Rec."Female Members")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = Customers;
                    ToolTip = 'Specifies the number of female members';
                    Image = none;
                }

                actions
                {
                    action("New Member")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Members';
                        RunObject = Page Customers;
                        RunPageMode = Create;
                        ToolTip = 'Creates a New member.';
                        Image = none;
                    }
                }
            }
            cuegroup("Projects")
            {
                Caption = 'Projects';
                field("Total Projects"; Rec."Total Projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Projects';
                    DrillDownPageID = Projects;
                    ToolTip = 'Specifies the number of projects.';
                    Image = none;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FieldNo("Total Projects"));
                    end;
                }
                field("Total Plots"; Rec."Total Plots")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Plots';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of plots.';
                    Image = none;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FieldNo("Total Plots"));
                    end;
                }
                field("Plots Sold"; Rec."Plots Sold")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Plots Sold';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of plots sold.';
                    Image = none;
                    trigger OnDrillDown()
                    begin
                        Rec.ShowOrders(Rec.FieldNo("Plots Sold"));
                    end;
                }
                field("Plots Being Repaid"; Rec."Plots Being Repaid")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Plots being Repaid';
                    Image = Calendar;
                    ToolTip = 'Specifies the number of plots being repaid';
                }

                actions
                {
                    action(Navigate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Find entries...';
                        RunObject = Page Navigate;
                        ShortCutKey = 'Ctrl+Alt+Q';
                        ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                    }
                }
            }
            cuegroup(Totals)
            {
                Caption = 'Figures';

                field("Total Shares"; Rec."Total Shares")
                {
                    ApplicationArea = SalesReturnOrder;
                    DrillDownPageID = Customers;
                    ToolTip = 'Specifies the total Shares';
                }

                field("Total Deposits"; Rec."Total Deposits")
                {
                    ApplicationArea = SalesReturnOrder;
                    DrillDownPageID = Customers;
                    ToolTip = 'Specifies the total deposits';
                }
                field("Total Plot Outstanding Amount"; Rec."Total Plot Outstanding Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    DrillDownPageID = "Sales Credit Memos";
                    ToolTip = 'Specifies the total plots outstanding amount.';
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'New Sales Return Order';
                        RunObject = Page "Sales Return Order";
                        RunPageMode = Create;
                        ToolTip = 'Process a return or refund that requires inventory handling by creating a new sales return order.';
                    }
                    action("New Sales Credit Memo")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Sales Credit Memo';
                        RunObject = Page "Sales Credit Memo";
                        RunPageMode = Create;
                        ToolTip = 'Process a return or refund by creating a new sales credit memo.';
                    }
                }
            }
            cuegroup("Document Exchange Service")
            {
                Caption = 'Document Exchange Service';
                Visible = ShowDocumentsPendingDodExchService;
                field("Sales Inv. - Pending Doc.Exch."; Rec."Sales Inv. - Pending Doc.Exch.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies sales invoices that await sending to the customer through the document exchange service.';
                    Visible = ShowDocumentsPendingDodExchService;
                }
                field("Sales CrM. - Pending Doc.Exch."; Rec."Sales CrM. - Pending Doc.Exch.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies sales credit memos that await sending to the customer through the document exchange service.';
                    Visible = ShowDocumentsPendingDodExchService;
                }
            }
            /*             usercontrol(SATAsyncLoader; SatisfactionSurveyAsync)
                        {
                            ApplicationArea = Basic, Suite;
                            trigger ResponseReceived(Status: Integer; Response: Text)
                            var
                                SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
                            begin
                                SatisfactionSurveyMgt.TryShowSurvey(Status, Response);
                            end;

                            trigger ControlAddInReady();
                            begin
                                IsAddInReady := true;
                                CheckIfSurveyEnabled();
                            end;
                        } */
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        TaskParameters: Dictionary of [Text, Text];
    begin
        TaskParameters.Add('View', Rec.GetView());
        if CalcTaskId <> 0 then
            if CurrPage.CancelBackgroundTask(CalcTaskId) then;
        CurrPage.EnqueueBackgroundTask(CalcTaskId, Codeunit::"SO Activities Calculate", TaskParameters, 120000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        ShowDocumentsPendingDodExchService := false;
        if DocExchServiceSetup.Get() then
            ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRespCenterFilter();
        Rec.SetRange("Date Filter", 0D, WorkDate());
        Rec.SetFilter("Date Filter2", '>=%1', WorkDate());
        Rec.SetRange("User ID Filter", UserId());

        RoleCenterNotificationMgt.ShowNotifications();
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent();

        /*         if PageNotifier.IsAvailable() then begin
                    PageNotifier := PageNotifier.Create();
                    PageNotifier.NotifyPageReady();
                end; */
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        SOActivitiesCalculate: Codeunit "SO Activities Calculate";
        PrevUpdatedOn: DateTime;
    begin
        if TaskId <> CalcTaskId then
            exit;

        CalcTaskId := 0;

        if Rec.Get() then;
        PrevUpdatedOn := Rec."Avg. Days Delayed Updated On";
        SOActivitiesCalculate.EvaluateResults(Results, Rec);
        ReadyToShip := Rec."Ready to Ship";
        AverageDaysDelayed := Rec."Average Days Delayed";
        DelayedOrders := Rec.Delayed;
        PartiallyShipped := Rec."Partially Shipped";

        if Rec.WritePermission and (Rec."Avg. Days Delayed Updated On" > PrevUpdatedOn) then begin
            PrevUpdatedOn := Rec."Avg. Days Delayed Updated On";
            Rec.LockTable();
            Rec.Get();
            Rec."Avg. Days Delayed Updated On" := PrevUpdatedOn;
            Rec."Average Days Delayed" := AverageDaysDelayed;
            if Rec.Modify() then;
            Commit();
        end;

        CurrPage.Update();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        AverageDaysDelayed: Decimal;
        ReadyToShip: Integer;
        PartiallyShipped: Integer;
        DelayedOrders: Integer;
        CalcTaskId: Integer;
        ShowDocumentsPendingDodExchService: Boolean;
        IsAddInReady: Boolean;
        IsPageReady: Boolean;

    /*     trigger PageNotifier::PageReady()
        begin
            IsPageReady := true;
            CheckIfSurveyEnabled();
        end; */

    /*     local procedure CheckIfSurveyEnabled()
        var
            SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
            CheckUrl: Text;
        begin
            if not IsAddInReady then
                exit;
            if not IsPageReady then
                exit;
            if not SatisfactionSurveyMgt.DeactivateSurvey() then
                exit;
            if not SatisfactionSurveyMgt.TryGetCheckUrl(CheckUrl) then
                exit;
            CurrPage.SATAsyncLoader.SendRequest(CheckUrl, SatisfactionSurveyMgt.GetRequestTimeoutAsync());
        end; */
}