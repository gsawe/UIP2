//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512361 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Assigned No."; Rec."Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Category';
                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual,Joint';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Corporate then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                group(Control40)
                {
                    Visible = Joint2DetailsVisible;
                    field("Joint Account Name"; Rec."Joint Account Name")
                    {
                        ApplicationArea = Basic;
                        Enabled = FirstNameEditable;
                        Visible = Joint2DetailsVisible;
                    }
                    field("Signing Instructions"; Rec."Signing Instructions")
                    {
                        ApplicationArea = Basic;
                        Enabled = FirstNameEditable;
                        Visible = Joint2DetailsVisible;
                    }
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name";
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Identification Document"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = IdentificationDocTypeEditable;

                    trigger OnValidate()
                    begin
                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("IPRS Details"; Rec."IPRS Details")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("IPRS Error Description"; Rec."IPRS Error Description")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassportEditable;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = KRAPinEditable;
                    ShowMandatory = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    // ShowMandatory = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; Rec."Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = SecondaryMobileEditable;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                }
                field("E-mail Indemnified"; Rec."E-mail Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = EmailIndemnifiedEditable;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    //ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    //ShowMandatory = true;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country';
                    Editable = CountryEditable;
                    // LookupPageId = Rec.CountriesLookup;

                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    Visible = false;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Member's Residence"; Rec."Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = MemberResidenceEditable;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = PhysicalAddressEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Final Approver"; Rec."Final Approver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved By';
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Occupation Details")
            {
                Caption = 'Occupation Details';
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        EmployedVisible := false;
                        SelfEmployedVisible := false;
                        OtherVisible := false;

                        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
                            EmployedVisible := true;
                        end;

                        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
                            SelfEmployedVisible := true;
                        end;

                        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
                            OtherVisible := true;
                        end;

                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                group(Employed)
                {
                    Caption = 'Employment Details';
                    Visible = EmployedVisible;
                    field("Employment Status"; Rec."Employment Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Employer Code"; Rec."Employer Code")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerCodeEditable;
                        ShowMandatory = true;
                    }
                    field("Employer Name"; Rec."Employer Name")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployedEditable;
                    }
                    field("Employer Address"; Rec."Employer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerAddressEditable;
                    }
                    field("Member Payment Type"; Rec."Member Payment Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Terms of Employment"; Rec."Terms of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = TermsofEmploymentEditable;
                        ShowMandatory = true;
                    }
                    field("Date of Employment"; Rec."Date of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = EmploymentDateEditable;
                    }
                    field("Position Held"; Rec."Position Held")
                    {
                        ApplicationArea = Basic;
                        Editable = PositionHeldEditable;
                    }
                }

                field("Expected Monthly Income Amount"; Rec."Expected Monthly Income Amount")
                {
                    ApplicationArea = Basic;
                }
                group(SelfEmployed)
                {
                    Caption = 'Self_Employment Details';
                    Visible = SelfEmployedVisible;
                    field("Nature Of Business"; Rec."Nature Of Business")
                    {
                        ApplicationArea = Basic;
                        Editable = NatureofBussEditable;
                    }
                    field(Industry; Rec.Industry)
                    {
                        ApplicationArea = Basic;
                        Editable = IndustryEditable;
                    }
                    field("Business Name"; Rec."Business Name")
                    {
                        ApplicationArea = Basic;
                        Editable = BusinessNameEditable;
                    }
                    field("Physical Business Location"; Rec."Physical Business Location")
                    {
                        ApplicationArea = Basic;
                        Editable = PhysicalBussLocationEditable;
                    }
                    field("Year of Commence"; Rec."Year of Commence")
                    {
                        ApplicationArea = Basic;
                        Editable = YearOfCommenceEditable;
                    }
                }
                group(Other)
                {
                    Caption = 'Details';
                    Visible = OtherVisible;
                    field("Others Details"; Rec."Others Details")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Occupation Details';
                        Editable = OthersEditable;
                    }
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Member Risk Ratings")
            {
                Visible = false;

                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }

                    field("Industry Type"; Rec."Industry Type")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }
                group("Product Risk Rating")
                {
                    //Visible = false;
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = false;
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }

            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("First Name2"; Rec."First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2";
                    end;
                }
                field("Middle Name2"; Rec."Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2";
                    end;
                }
                field("Last Name2"; Rec."Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2" + ' ' + Rec."Last Name2";
                    end;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; Rec."Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender2; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }

                field("Employer Name2"; Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; Rec."First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3";
                    end;
                }
                field("Middle Name 3"; Rec."Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3";
                    end;
                }
                field("Last Name3"; Rec."Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3" + ' ' + Rec."Last Name3";
                    end;
                }
                field("Name 3"; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; Rec."Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender3; Rec.Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin




                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*     if Confirm('Are you sure you want to cancel this approval request', false) = true then
                                WorkflowManagement.OnCancelMembershipApplicationApprovalRequest(Rec); */

                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.SetRecordFilters(Database::"Membership Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = EnableCreateMember;

                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        ObjAccountType: Record "Account Types-Saving Products";
                        SaccoNoSeries: Record "Sacco No. Series";
                    begin
                        Rec.TestField("Monthly Contribution");

                        if Confirm('Are you sure you want to create the selected accounts for the New Member?', false) = true then begin

                            //================================================================================================Back office Account

                            SaccoNoSeries.Get();
                            VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos", Today, true);

                            //Create Member
                            Message('the number is %1', VarNewMembNo);
                            CustomerTable."No." := Format(VarNewMembNo);
                            CustomerTable.Name := Rec.Name;
                            CustomerTable.Address := Rec.Address;
                            CustomerTable."Address 2" := Rec."Address 2";
                            CustomerTable."Post Code" := Rec."Postal Code";
                            CustomerTable.Town := Rec.Town;
                            CustomerTable.County := Rec.County;
                            CustomerTable.ISNormalMember := true;
                            CustomerTable.City := Rec.City;
                            CustomerTable."Country/Region Code" := Rec."Country/Region Code";
                            CustomerTable."Phone No." := Rec."Phone No.";
                            CustomerTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            CustomerTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            CustomerTable."Customer Posting Group" := Rec."Customer Posting Group";
                            CustomerTable."Registration Date" := Today;
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Member Type" := CustomerTable."Member Type"::Member;
                            CustomerTable.Status := CustomerTable.Status::Active;
                            CustomerTable."Date of Birth" := Rec."Date of Birth";
                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;
                            CustomerTable."Station/Department" := Rec."Station/Department";
                            CustomerTable."E-Mail" := Rec."E-Mail (Personal)";
                            CustomerTable.Location := Rec.Location;
                            CustomerTable.Title := Rec.Title;
                            CustomerTable."Home Address" := Rec."Home Address";
                            CustomerTable."Home Postal Code" := Rec."Home Postal Code";
                            CustomerTable."Home Town" := Rec."Home Town";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Member Share Class" := Rec."Member Share Class";
                            CustomerTable."Member's Residence" := Rec."Member's Residence";
                            CustomerTable."Member House Group Name" := Rec."Member House Group Name";
                            CustomerTable."Occupation Details" := Rec."Employment Info";
                            CustomerTable."Employer Code" := Rec."Employer Code";
                            CustomerTable."Employer Name" := Rec."Employer Name";
                            CustomerTable."Employer Address" := Rec."Employer Address";
                            CustomerTable."Terms Of Employment" := Rec."Terms of Employment";
                            CustomerTable."Date of Employment" := Rec."Date of Employment";
                            CustomerTable."Position Held" := Rec."Position Held";
                            CustomerTable."Expected Monthly Income Amount" := Rec."Expected Monthly Income Amount";
                            CustomerTable."Nature Of Business" := Rec."Nature Of Business";
                            CustomerTable.Industry := Rec.Industry;
                            CustomerTable."Business Name" := Rec."Business Name";
                            CustomerTable."Physical Business Location" := Rec."Physical Business Location";
                            CustomerTable."Year of Commence" := Rec."Year of Commence";
                            CustomerTable."Identification Document" := Rec."Identification Document";
                            CustomerTable."Referee Member No" := Rec."Referee Member No";
                            CustomerTable."Referee Name" := Rec."Referee Name";
                            CustomerTable."Referee ID No" := Rec."Referee ID No";
                            CustomerTable."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            CustomerTable."Email Indemnified" := Rec."E-mail Indemnified";
                            CustomerTable."Created By" := UserId;
                            CustomerTable."Member Needs House Group" := Rec."Member Needs House Group";
                            CustomerTable."First Name" := Rec."First Name";
                            CustomerTable."Middle Name" := Rec."Middle Name";
                            CustomerTable."Last Name" := Rec."Last Name";
                            CustomerTable.ISNormalMember := true;


                            //*****************************to Sort Joint
                            CustomerTable."Name 2" := Rec."Name 2";
                            CustomerTable.Address3 := Rec.Address3;
                            CustomerTable."Postal Code 2" := Rec."Postal Code 2";
                            CustomerTable."Home Postal Code2" := Rec."Home Postal Code2";
                            CustomerTable."Home Town2" := Rec."Home Town2";
                            CustomerTable."ID No.2" := Rec."ID No.2";
                            CustomerTable."Passport 2" := Rec."Passport 2";
                            CustomerTable.Gender2 := Rec.Gender2;
                            CustomerTable."Marital Status2" := Rec."Marital Status2";
                            CustomerTable."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                            // CustomerTable."Employer Code2" := Rec."Employer Code2";
                            CustomerTable."Employer Name2" := Rec."Employer Name2";
                            CustomerTable."Picture 2" := Rec."Picture 2";
                            CustomerTable."Signature  2" := Rec."Signature  2";


                            CustomerTable."Name 3" := Rec."Name 3";
                            CustomerTable."Address3-Joint" := Rec.Address4;
                            CustomerTable."Postal Code 3" := Rec."Postal Code 3";
                            CustomerTable."Home Postal Code3" := Rec."Home Postal Code3";
                            CustomerTable."Mobile No. 4" := Rec."Mobile No. 4";
                            CustomerTable."Home Town3" := Rec."Home Town3";
                            CustomerTable."ID No.3" := Rec."ID No.3";
                            CustomerTable."Passport 3" := Rec."Passport 3";
                            CustomerTable.Gender3 := Rec.Gender3;
                            CustomerTable."Marital Status3" := Rec."Marital Status3";
                            CustomerTable."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                            CustomerTable."Employer Code3" := Rec."Employer Code3";
                            CustomerTable."Employer Name3" := Rec."Employer Name3";
                            CustomerTable."Picture 3" := Rec."Picture 3";
                            CustomerTable."Signature  3" := Rec."Signature  3";
                            CustomerTable."Account Category" := Rec."Account Category";
                            CustomerTable."Joint Account Name" := Rec."Joint Account Name";
                            if Rec."Account Category" = Rec."account category"::Joint then
                                CustomerTable.Name := Rec."Joint Account Name";
                            //===================================================================================End Joint Account Details

                            //**
                            CustomerTable."Office Branch" := Rec."Office Branch";
                            CustomerTable.Department := Rec.Department;
                            CustomerTable.Occupation := Rec.Occupation;
                            CustomerTable.Designation := Rec.Designation;
                            CustomerTable."Bank Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Name" := UpperCase(Rec."Bank Branch Name");
                            CustomerTable."Bank Name" := Rec."Bank Name";
                            CustomerTable."Bank Account No." := Rec."Bank Account No";
                            //**
                            CustomerTable."Sub-Location" := Rec."Sub-Location";
                            CustomerTable.District := Rec.District;
                            CustomerTable."Payroll No" := Rec."Payroll No";
                            CustomerTable."ID No." := Rec."ID No.";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Marital Status" := Rec."Marital Status";
                            CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                            CustomerTable.Gender := Rec.Gender;

                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;

                            //CustomerTable."Monthly Contribution" := Rec."Monthly Contribution";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."Contact Person Phone" := Rec."Contact Person Phone";
                            //CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Village/Residence" := Rec."Village/Residence";
                            CustomerTable.Pin := Rec."KRA PIN";
                            CustomerTable."KYC Completed" := true;


                            //======================================================Create Standing Order No.
                            if Rec."Member Payment Type" = Rec."member payment type"::"Standing Order" then begin
                                if ObjNoSeries.Get then begin
                                    ObjNoSeries.TestField(ObjNoSeries."Standing Order Members Nos");
                                    VarStandingNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Standing Order Members Nos", 0D, true);
                                    if VarStandingNo <> '' then begin
                                        CustomerTable."Standing Order No" := VarStandingNo;
                                    end;
                                end;
                            end;
                            CustomerTable.Insert(true);



                            VarBOSAACC := CustomerTable."No.";

                        end;

                        //==================================================================================================End Membership Registration


                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                        //=================================================================================================================End Member Accounts




                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                            VarAccounts := '';
                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
                            if ObjAccounts.FindSet then begin
                                repeat
                                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                                        VarAccounts := VarAccounts + Format(ObjAccounts."No.") + ' - ' + Format(ObjAccountType."Product Short Name") + '; ';
                                    end;
                                until ObjAccounts.Next = 0;
                            end;
                            SFactory.FnSendSMS('MEMBERAPP', 'You Membership Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                            VarBOSAACC, Rec."Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.", VarBOSAACC);
                        end;
                        Rec.Created := true;

                        Rec.CalcFields("Assigned No.");
                        //FnRuninsertBOSAAccountNos("Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    // WorkflowManagement: Codeunit "Workflow Management";
    // WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        EnableUpdateKYC := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;

        if Rec.Created = true then
            EnableCreateMember := false;

        if (Rec.Created = true) and (Rec."KYC Completed" = false) and (Rec."Online Application" = true) then
            EnableUpdateKYC := true;

        ObjGenSetUp.Get;
        Rec."Monthly Contribution" := ObjGenSetUp."Min. Contribution";
    end;

    trigger OnAfterGetRecord()
    begin

        StyleText := 'UnFavorable';



        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
            OtherVisible := true;
        end;

        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;

        SetStyles();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Responsibility Centre" := ObjUserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        ObjGenSetUp.Get();
        Rec."Monthly Contribution" := ObjGenSetUp."Monthly Share Contributions";
        Rec."Customer Posting Group" := ObjGenSetUp."Default Customer Posting Group";


    end;

    trigger OnOpenPage()
    begin

        if ObjUserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", ObjUserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" = Rec."account category"::Corporate then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if Rec."Account Category" = Rec."account category"::Individual then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
            OtherVisible := true;
        end;




        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;
    end;

    var
        //StatusPermissions: Record "Status Change Permision";
        ObjCust: Record "Members Register";
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        //ObjNextOfKinApp: Record "Member App Nominee";
        //ObjAccountSign: Record "FOSA Account Sign. Details";
        //ObjAccountSignApp: Record "Member App Signatories";
        ObjAcc: Record Vendor;
        UsersID: Record User;
        //ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
        text001: label 'Status must be open';
        ObjUserMgt: Codeunit "User Setup Management";
        ObjNotificationE: Codeunit Mail;
        VarMailBody: Text[250];
        VarccEmail: Text[1000];
        VartoEmail: Text[1000];
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarClearingAcctNo: Code[20];
        VarAdvrAcctNo: Code[20];
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarDivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        VarNewMembNo: Code[30];
        ObjSaccosetup: Record "Sacco No. Series";
        //ObjNOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        //ObjDataSheet: Record "Data Sheet Main";
        ObjSMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ObjProductsApp: Record "Membership Reg. Products Appli";
        //ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjUsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        // ObjViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        //ObjAccountAppAgent: Record "Account Agents App Details";
        //ObjAccountAgent: Record "Account Agent Details";
        //ObjMemberAppAgent: Record "Member Agents App Details";
        //ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        RefereeEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        //ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record "Members Register";
        //ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        StyleText: Text[20];
        CoveragePercentStyle: Text;
        //ObjMemberNoseries: Record "Member Accounts No Series";
        VarAccountTypes: Text[1000];
        VarAccountDescription: Text[1000];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text[100];
        SurestepFactory: Codeunit "SURESTEP Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEnableNeedHouse: Boolean;
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarProductCount: Integer;
        //ObjMemberAppSignatories: Record "Member App Signatories";
        EnableUpdateKYC: Boolean;
        VarStandingNo: Code[20];
        WorkflowManagement: Codeunit WorkflowIntegration;
        CustomerTable: Record Customer;


    procedure UpdateControls()
    begin

        if (Rec.Status = Rec.Status::Approved) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = true)) then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if (Rec.Status = Rec.Status::Open) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = false)) then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            NatureofBussEditable := true;
            IndustryEditable := true;
            BusinessNameEditable := true;
            PhysicalBussLocationEditable := true;
            YearOfCommenceEditable := true;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBAPP';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBREG';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + VarBOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;



    local procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            Rec.TestField(Name);
            Rec.TestField("ID No.");
            Rec.TestField("Mobile Phone No");
            Rec.TestField("Country/Region Code");
            Rec.TestField("Monthly Contribution");
            Rec.TestField(Gender);
            Rec.TestField("Employment Info");
            Rec.TestField("KRA PIN");
            Rec.TestField("Customer Posting Group");
            if Rec."Account Category" = Rec."account category"::Individual then begin
                //TESTFIELD(Picture);
                //TESTFIELD(Signature);
            end;
        end else

            if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                Rec.TestField(Name);
                Rec.TestField("Registration No");
                Rec.TestField("Copy of KRA Pin");
                Rec.TestField("Member Registration Fee Receiv");
                Rec.TestField("Customer Posting Group");
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");

            end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        //  SMTPMail: Codeunit "SMTP Mail";
        //  SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        recipient: List of [Text];
    begin
        // SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        Memb.SetFilter(Memb."E-Mail (Personal)", '<>%1', '');
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            //     if Memb."E-Mail (Personal)" <> '' then
            //         recipient.Add(Email);
            //     SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", recipient, 'Membership Application', '', true);
            //     SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            //     SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            //     SMTPMail.AppendBody('<br><br>');
            //     SMTPMail.AddAttachment(FileName, Attachment);
            //SMTPMail.Send;
        end;




    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Vision Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Vision Sacco.</p>' +
               '<p>7. Process your salary to your Vision Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.visionsacco.com">www.visionsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Vision Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO VISION SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Vision Sacco. Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        //  SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        /*ObjSaccosetup.GET;
        
        //SHARE CAPITAL
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'601');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(HQ)");
                ObjSaccosetup."Share Capital Account No(HQ)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NAIV)");
                ObjSaccosetup."Share Capital Account No(NAIV)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NKR)");
                  ObjSaccosetup."Share Capital Account No(NKR)":=ObjMembers."Share Capital No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='601';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(ELD)");
                    ObjSaccosetup."Share Capital Account No(ELD)":=ObjMembers."Share Capital No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='601';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(MSA)");
                      ObjSaccosetup."Share Capital Account No(MSA)":=ObjMembers."Share Capital No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='601';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        //END SHARE CAPITAL
        
        //DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'602');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='602';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='602';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='602';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //CORPORATE DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'603');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='603';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='603';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='603';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'605');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='605';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='605';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='605';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'607');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='607';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='607';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='607';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //BENEVOLENT FUND
        
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'606');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(HQ)");
                ObjSaccosetup."BenFund Account No(HQ)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
        
              END;
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NAIV)");
                ObjSaccosetup."BenFund Account No(NAIV)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NKR)");
                  ObjSaccosetup."BenFund Account No(NKR)":=ObjMembers."Benevolent Fund No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='606';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(ELD)");
                    ObjSaccosetup."BenFund Account No(ELD)":=ObjMembers."Benevolent Fund No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='606';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(MSA)");
                      ObjSaccosetup."BenFund Account No(MSA)":=ObjMembers."Benevolent Fund No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='606';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
          */

    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin
        /*
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETRANGE(ObjAccounts."Account Type",'SHARECAP');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Share Capital No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
        
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type",'=%1','DEPOSITS');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Deposits Account No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
        
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type",'=%1','BENFUND');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Benevolent Fund No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
            */

    end;

    local procedure FnRunAMLDueDiligenceCheck()
    begin
        Rec.TestField("Individual Category");
        Rec.TestField("Member Residency Status");
        Rec.TestField("Industry Type");
        Rec.TestField("Length Of Relationship");
        Rec.TestField("International Trade");
        Rec.TestField("Electronic Payment");
        Rec.TestField("Accounts Type Taken");
        Rec.TestField("Cards Type Taken");
        Rec.TestField("Others(Channels)");
    end;




    local procedure FnSendKYCUpdateEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Demo Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Demo Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Demo Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Demo Sacco.</p>' +
               '<p>7. Process your salary to your Demo Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.Demosacco.com">www.Demosacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Demo Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'MEMBERSHIP KYC DETAILS UPDATED - ' + VarMemberNo;
        VarEmailBody := '<p>Your Membership KYC Details have successfully been updated. You can now transact on your Accounts without any limits.</p>' +
              '<p>Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + '</p>' + VarTextExtension + VarTextExtensionII;

        //SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;
}




