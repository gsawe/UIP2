page 51510222 "Investment Role"
{
    PageType = RoleCenter;
    Caption = 'Investment Role';

    layout
    {
        area(RoleCenter)
        {
            part(Control104; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }

            part(Control1901851508; "User Task Cue AU")
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1907692008; "Customers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Investment Members';
            }
            part(Control1905989631; "Due Diligence List Part")
            {
                Caption = 'Due Diligence List';
                AccessByPermission = TableData "Due Diligences" = R;
                ApplicationArea = Basic, Suite;
            }

            part(Control1905989608; "Projects Part")
            {
                Caption = 'Projects';
                AccessByPermission = TableData Projects = R;
                ApplicationArea = Basic, Suite;
            }
            part(Control1905989620; "Plots Part")
            {
                Caption = 'Plots';
                AccessByPermission = TableData Plots = R;
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control14; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }

            part(Control1; "Trailing Sales Orders Chart")
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                Visible = false;
                ApplicationArea = Basic, Suite;
            }
            part(Control4; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;

            }

            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control21; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Suite;
                Visible = false;
            }

            part(Control13; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced by PowerBIEmbeddedReportPart';
                Visible = false;
                ObsoleteTag = '21.0';
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage sales processes, view KPIs, and access your favorite items and customers.';

            action("Parcel Regitration(Due Diligence)")
            {
                ApplicationArea = Basic, Suite;
                //Caption = 'Parcel Registration(Due Diligence)';
                Image = "Order";
                RunObject = Page "Due Diligence List";
            }
            action("Parcel Search(Due Diligence)")
            {
                ApplicationArea = Basic, Suite;
                //Caption = 'Parcel Search(Due Diligence)';
                Image = "Order";
                RunObject = Page "Due Diligence Search List";
            }
            action("Successful Projects(Due Diligence)")
            {
                ApplicationArea = Basic, Suite;
                //Caption = 'Successful Projects(Due Diligence)';
                Image = "Order";
                RunObject = Page "Due Diligence List Posted";
            }
            action("Project Registration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Project Registration';
                Image = "Order";
                RunObject = Page "Project List";
            }

            action(Plots)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plots';
                Image = "Order";
                RunObject = Page Plots;
            }

            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = "Order";
                RunObject = Page Customers;
            }
            action("Plots Sales")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plots Sales List';
                Image = "Order";
                RunObject = Page "Plots Application List";
            }

            action("Plots Sales Posted")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Plots Sales List';
                Image = "Order";
                RunObject = Page "Plots Application List Posted";
            }

            action("Plot Release")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plots Release List';
                Image = "Order";
                RunObject = Page "Release List";
            }

            action("Plots Receipting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plots Receipting';
                Image = "Order";
                RunObject = Page "Receipts list-BOSA";
            }
            action("Title Deed List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Title Deed List';
                Image = "Order";
                RunObject = Page "Received Title Deed List";
            }

            action("Issue Title Deed.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Title Deed';
                Image = "Order";
                RunObject = Page "Title Processing List";
            }

            action("Issued Title Deed.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issued Title Deeds';
                Image = "Order";
                RunObject = Page "Title Processing List Posted";
            }

            action("Checkoff Processing")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Checkoff Processing List';
                Image = "Order";
                RunObject = Page "Checkoff Processing-D List";
            }

            action("Checkoff Processing Posted")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Checkoff Processing List Posted';
                Image = "Order";
                RunObject = Page "Checkoff Processing List P";
            }

            action("Number Series")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Number Series';
                Image = "Order";
                RunObject = Page "Number Serires";
            }
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales documents that are shipped but not yet invoiced.';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    "Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Sales Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
            }
            action("Transfer Orders")
            {
                ApplicationArea = Location;
                Visible = false;
                Caption = 'Transfer Orders';
                RunObject = Page "Transfer Orders";
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
            }
        }
        area(sections)
        {


            group(Action51510000)
            {
                Caption = 'Investment';
                Image = Sales;
                ToolTip = 'Investment Module.';
                action(Action120)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Parcel Registration(Due Diligence)';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Due Diligence List";
                    ToolTip = 'Due Diligence.';
                }

                Action(Action142)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Parcel Search(Due Diligence)';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Due Diligence Search List";
                    ToolTip = 'Parcel Search(Due Diligence)';
                }

                action(Action144)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Successful Projects(Due Diligence)';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Due Diligence List Posted";
                    ToolTip = 'Successful Projects(Due Diligence)';
                }
                action(Action241)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Membership Applications';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership Application List";
                    ToolTip = 'Membership Application List';
                }


                action(Action145)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Investment Members';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Customers;
                    ToolTip = 'Investment Members';
                }

                action(Action121)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Registration';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Project List";
                    ToolTip = 'View or edit detailed information for projects.';
                }

                action(Action122)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Plots';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Plots;
                    ToolTip = 'View or edit detailed information for plots.';
                }


                action(Action123)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Plot Sales List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Plots Application List";
                    ToolTip = 'Buy a Plot.';
                }

                action(Action124)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Plot Sales';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Plots Application List Posted";
                    ToolTip = 'Buy a Plot.';
                }

                action(Action125)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Members Receipting';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipts list-BOSA";
                    ToolTip = 'Members Receipting.';
                }
                action(Action566)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Members Receipting';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipts list-BOSA Posted";
                    ToolTip = 'Members Receipting Posted.';
                }
                action(Action181)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Title Deed List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Received Title Deed List";
                    ToolTip = 'Register Title Deeds.';
                }

                action(Action166)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Title Processing List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Title Processing List";
                    ToolTip = 'View title deeds Proccesing.';
                }
                action(Action190)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Issued Title Deeds List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Title Processing List Posted";
                    ToolTip = 'View issued title deeds.';
                }

                action(Action458)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Checkoff Processing List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Processing-D List";
                    ToolTip = 'Checkoff Processing List';
                }



                action(Action590)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Checkoff Processing List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Processing List P";
                    ToolTip = 'Posted Checkoff Processing List';
                }

            }
            group(Action39)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Post financial transactions, manage budgets, analyze G/L  data, and prepare financial statements.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'G/L Account Categories';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action("G/L Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Budget Names";
                    ToolTip = 'View summary information about the amount budgeted for each general ledger account in different time periods.';
                }
                action(Action300)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Financial Reporting';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Financial Reports";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Financial reports analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Financial reports provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action("Intrastat Journals")
                {
                    ApplicationArea = BasicEU;
                    visible = false;
                    Caption = 'Intrastat Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Intrastat Jnl. Batches";
                    ToolTip = 'Summarize the value of your purchases and sales with business partners in the EU for statistical purposes and prepare to send it to the relevant authority.';
                }
                action("Sales Budgets")
                {
                    ApplicationArea = SalesBudget;
                    visible = false;
                    Caption = 'Sales Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Budget Names Sales";
                    ToolTip = 'Enter item sales values of type amount, quantity, or cost for expected item sales in different time periods. You can create sales budgets by items, customers, customer groups, or other dimensions in your business. The resulting sales budgets can be reviewed here or they can be used in comparisons with actual sales data in sales analysis reports.';
                }
                action("Purchase Budgets")
                {
                    ApplicationArea = PurchaseBudget;
                    visible = false;
                    Caption = 'Purchase Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Budget Names Purchase";
                    ToolTip = 'Enter item purchases values of type amount, quantity, or cost for expected item purchases in different time periods. You can create purchase budgets by items, vendors, vendor groups, or other dimensions in your business. The resulting purchase budgets can be reviewed here or they can be used in comparisons with actual purchases data in purchase analysis reports.';
                }
                action("Sales Analysis Reports")
                {
                    ApplicationArea = SalesAnalysis;
                    visible = false;
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page "Analysis Report Sale";
                    ToolTip = 'Analyze the dynamics of your sales according to key sales performance indicators that you select, for example, sales turnover in both amounts and quantities, contribution margin, or progress of actual sales against the budget. You can also use the report to analyze your average sales prices and evaluate the sales performance of your sales force.';
                }
                action("Purchase Analysis Reports")
                {
                    ApplicationArea = PurchaseAnalysis;
                    visible = false;
                    Caption = 'Purchase Analysis Reports';
                    RunObject = Page "Analysis Report Purchase";
                    ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
                }
                action("Inventory Analysis Reports")
                {
                    ApplicationArea = InventoryAnalysis;
                    visible = false;
                    Caption = 'Inventory Analysis Reports';
                    RunObject = Page "Analysis Report Inventory";
                    ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
                }
                action("VAT Returns")
                {
                    ApplicationArea = VAT;
                    visible = false;
                    Caption = 'VAT Returns';
                    RunObject = Page "VAT Report List";
                    ToolTip = 'Prepare the VAT Return report so you can submit VAT amounts to a tax authority.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    visible = false;
                    Caption = 'Currencies';
                    Image = Currency;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Employees)
                {
                    ApplicationArea = BasicHR;
                    visible = false;
                    Caption = 'Employees';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("VAT Statements")
                {
                    ApplicationArea = VAT;
                    visible = false;
                    Caption = 'VAT Statements';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "VAT Statement Names";
                    ToolTip = 'View a statement of posted VAT amounts, calculate your VAT settlement amount for a certain period, such as a quarter, and prepare to send the settlement to the tax authorities.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(PostedGeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted General Journals';
                    RunObject = Page "Posted General Journal";
                    ToolTip = 'Open the list of posted general journal lines.';
                }
            }


            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.';
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(CashReceiptJournalss)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action23)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Direct Debit Collections';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Direct Debit Collections";
                    ToolTip = 'Instruct your bank to withdraw payment amounts from your customer''s bank account and transfer them to your company''s account. A direct debit collection holds information about the customer''s bank account, the affected sales invoices, and the customer''s agreement, the so-called direct-debit mandate. From the resulting direct-debit collection entry, you can then export an XML file that you send or upload to your bank for processing.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
                action(Deposits)
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Bank Deposits';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = codeunit "Open Deposits Page";
                    ToolTip = 'Manage bank deposits to your bank accounts.';
                }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                action("Check Payment")
                {

                    Caption = 'Check Payment ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Payment Voucher List";
                    ToolTip = 'Payment Voucher List.';
                }

                action("Cash Payment")
                {

                    Caption = 'New Petty Cash Payments List ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "New Petty Cash Payments List";
                    ToolTip = 'New Petty Cash Payments List.';
                }
                action("Posted Cash Payment")
                {

                    Caption = 'Posted Cash Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Petty Cash Payments";
                    ToolTip = 'Posted Cash Payment';
                }
                action("Posted Cheque Payment")
                {

                    Caption = 'Posted Cheque Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Cheque Payment Vouchers";
                    ToolTip = 'Posted Cheque Payment';
                }





                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posred Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                }

                action("Receipt Header List")
                {
                    Caption = 'Receipt Header List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Receipt Header List";
                    ToolTip = 'Receipt Header List';
                }

                action("Posted Receipt Header List ")
                {
                    Caption = 'Posted Receipt Header List ';
                    ApplicationArea = Basic, Suite;
                    Image = PostedOrder;
                    RunObject = page "Posted Receipt Header List";
                    ToolTip = 'Posted Receipt Header List ';
                }

            }
            group("Payments Setup")
            {
                Caption = 'Payment Setup';
                Image = Setup;
                ToolTip = 'Payment Setup.';
                action("Funds Genral Setup")
                {

                    Caption = 'Funds General Setup. ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds General Setup";
                    ToolTip = 'Funds General Setup.';
                }

                action("Budgetary Control Setup")
                {

                    Caption = 'Budgetary Control Setup ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Budgetary Control Setup";
                    ToolTip = 'Budgetary Control Setup';
                }
                action("Funds User Setup")
                {

                    Caption = 'Funds User Setup ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds User Setup";
                    ToolTip = 'Funds User Setup';
                }
                action("Receipt and Payment Types List")
                {

                    Caption = 'Receipt and Payment Types List';
                    ApplicationArea = Basic, Suite;
                    Image = Setup;
                    RunObject = page "Receipt and Payment Types List";
                    ToolTip = 'Receipt and Payment Types List';
                }
            }
            Group(SaccoPayroll)
            {
                Caption = 'Payroll Management';
                Visible = true;
                group(payrollEmployees)
                {
                    Caption = 'Payroll Employees';
                    action(payrollemp)
                    {
                        Caption = 'Payroll Employees list';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Payroll Employee List.";
                        tooltip = 'Open Payroll Employees list';
                    }
                    action(Exitedpayrollemp)
                    {
                        Caption = 'Exited Payroll Employees list';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Exited Payroll Employees";
                        tooltip = 'Open exited Payroll Employees list';
                        Visible = false;
                    }
                    action("Hr Employee List")
                    {
                        Caption = 'Hr Employee List';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Employee List";
                    }
                }
                group(PayrollEarnings)
                {
                    Caption = 'Earnings&Deductions';
                    Visible = true;
                    action(Earnings)
                    {
                        Caption = 'Payroll Earnings';
                        ApplicationArea = basic, suite;
                        Image = Card;
                        RunObject = page "Payroll Earnings List.";

                    }
                    action(Deductions)
                    {
                        Caption = 'Payroll Deductions';
                        ApplicationArea = basic, suite;
                        Image = Card;
                        RunObject = page "Payroll Deductions List.";

                    }
                }
                group(payrollsetup)
                {
                    action(payesetup)
                    {
                        Caption = 'PAYE SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll PAYE Setup.";
                    }
                    action(NHIF)
                    {
                        Caption = 'NHIF SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll NHIF Setup.";
                    }
                    action(NSSF)
                    {
                        Caption = 'NSSF SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll NSSF Setup.";
                    }
                    action(Payrolposting)
                    {
                        Caption = 'Payroll Posting group';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Posting Group.";
                    }
                    action(Payrollpostingsetup)
                    {
                        caption = 'Payroll posting setup';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Posting Setup Ver1";
                    }
                    action("PayrollTransaction")
                    {
                        caption = 'PayrollTransaction';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Transaction List.";
                    }
                    action(PayrollGeneralsetup)
                    {
                        caption = 'Payroll General setup List';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll General Setup LIST.";
                    }
                    action("Control-Info")
                    {
                        caption = 'Control Information ';
                        ApplicationArea = basic, suite;
                        RunObject = page controlInfor;
                    }
                    action("Hr Setup")
                    {
                        caption = 'HR setup';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Setup";
                    }

                }
                group(payrollperiodicactivities)
                {
                    Caption = 'Payroll Periodic Activities';
                    action(payrollperiods)
                    {
                        Caption = 'Payroll Periods';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Periods.";
                    }
                    action(Transfertojournal)
                    {
                        Caption = 'Payroll Journal Transfer';
                        ApplicationArea = basic, suite;
                        RunObject = report "Payroll JournalTransfer.";

                    }
                    action(Payrolnettransfer)
                    {
                        Caption = 'Payroll Net Transfer';
                        ApplicationArea = basic, suite;
                        RunObject = report "Payroll Net Pay Transfer Ver1";
                    }
                    action(SendP9)
                    {
                        Caption = 'Send Payslip via Mail';
                        ApplicationArea = basic, suite;
                        RunObject = report "Send Payslips Via Mail";
                    }
                    action("Bank Schedule")
                    {
                        Caption = 'Bank Schedule';
                        ApplicationArea = basic, suite;
                        RunObject = report "Bank Schedule..";
                    }

                }


            }
            group("Leave Management")
            {

                action(" Leave Application")
                {
                    Caption = 'Leave Applications';
                    ApplicationArea = basic, suite;
                    RunObject = page "HR Leave Applications List";

                }
                action("Leave Applications(Pending)")
                {
                    Caption = 'Leave Applications(Pending)';
                    ApplicationArea = basic, suite;
                    //RunObject = page leave;

                }
                action("Leave Applications(Approved)")
                {
                    Caption = 'Leave Applications(Approved)';
                    ApplicationArea = basic, suite;
                    RunObject = page "HR Leave Applications History";

                }
                action("Leave Applications(Posted)")
                {
                    Caption = 'Leave Applications(Posted)';
                    ApplicationArea = basic, suite;
                    RunObject = page "Posted Leave Applications";

                }

                group("Hr Leave Setup")
                {
                    action("HR Leave Journal")
                    {
                        Caption = 'HR Leave Journal';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Journal Lines";
                    }
                    action("HR Leave Types")
                    {
                        Caption = 'HR Leave Types';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Types";
                    }
                    action("Leave Period List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Period List";
                        Caption = 'Leave Period List';
                    }
                }
            }


            group(Action76)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Action61)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Sales Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Sales Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Sales Orders - Microsoft Dynamics 365 Sales")
                {
                    ApplicationArea = Suite;
                    visible = false;
                    Caption = 'Sales Orders - Microsoft Dynamics 365 Sales';
                    RunObject = Page "CRM Sales Order List";
                    ToolTip = 'View sales orders in Dynamics 365 Sales that are coupled with sales orders in Business Central.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    visible = false;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    visible = false;
                    Caption = 'Sales Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders enable you to receive items from multiple sales documents with one sales return, automatically create related sales credit memos or other return-related documents, such as a replacement sales order, and support warehouse documents for the item handling. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Sales Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    visible = false;
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales return receipts.';
                }
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action(Action68)
                {
                    ApplicationArea = Location;
                    visible = false;
                    Caption = 'Transfer Orders';
                    Image = FinChargeMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Transfer Orders";
                    ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
                }
                action(Reminders)
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Reminders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Reminder List";
                    ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Finance Charge Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Finance Charge Memo List";
                    ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                }
            }
            group(Action63)
            {
                Caption = 'Purchasing';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';
                action(Vendors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Purchase Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Blanket Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Purchase Orders";
                    ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes.';
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Purchase Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action(PurchaseJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Opens a list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Opens a list of posted purchase credit memos.';
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Opens a list of posted purchase return shipments.';
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
            }
            group(Action62)
            {
                Caption = 'Inventory';
                ToolTip = 'Manage physical or service-type items that you trade in by setting up item cards with rules for pricing, costing, planning, reservation, and tracking. Set up storage places or warehouses and how to transfer between such locations. Count, adjust, reclassify, or revalue inventory.';
                action(Action93)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action(Action96)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(false));
                    ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    visible = false;
                    Caption = 'Item Charges';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Item Attributes")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Item Attributes';
                    RunObject = Page "Item Attributes";
                    ToolTip = 'Assign item attribute values to your items to enable rich searching and sorting options. When customers inquire about an item, either in correspondence or in an integrated web shop, they can then ask or search according to characteristics, such as height and model year. You can also assign item attributes to item categories, which then apply to the items that use the item categories in question.';
                }
                action("Item Tracking")
                {
                    ApplicationArea = ItemTracking;
                    visible = false;
                    Caption = 'Item Tracking';
                    RunObject = Page "Avail. - Item Tracking Lines";
                    ToolTip = 'Assign serial numbers and lot numbers to any outbound or inbound document for quality assurance, recall actions, and to control expiration dates and warranties. Use the Item Tracing window to trace items with serial or lot numbers backwards and forward in their supply chain';
                }
                action("Item Reclassification Journals")
                {
                    ApplicationArea = Warehouse;
                    visible = false;
                    Caption = 'Item Reclassification Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Transfer),
                                        Recurring = CONST(false));
                    ToolTip = 'Change information on item ledger entries, such as dimensions, location codes, bin codes, and serial or lot numbers.';
                }
                action("Phys. Inventory Journals")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Phys. Inventory Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Phys. Inventory"),
                                        Recurring = CONST(false));
                    ToolTip = 'Select how you want to maintain an up-to-date record of your inventory at different locations.';
                }
                action("Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    visible = false;
                    Caption = 'Assembly Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Assembly Orders";
                    ToolTip = 'Combine components in simple processes without the need of manufacturing functionality. Sell assembled items by building the item to order or by picking from stock.';
                }
                action("Drop Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Drop Shipments';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Lines";
                    RunPageView = WHERE("Drop Shipment" = CONST(true));
                    ToolTip = 'Minimize delivery time and inventory cost by having items shipped from your vendor directly to your customer. This simply requires that you mark the sales order for drop shipment and then create a linked purchase order with the customer specified as the recipient. ';
                }
                action(Locations)
                {
                    ApplicationArea = Location;
                    Caption = 'Locations';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Location List";
                    ToolTip = 'Manage the different places or warehouses where you receive, process, or ship inventory to increase customer service and keep inventory costs low.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';
                action(Action32)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action(Action34)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted return receipts.';
                }
                action(Action40)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Sales Quote Archive")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quote Archives';
                    RunObject = page "Sales Quote Archives";
                }
                action("Sales Order Archive")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order Archives';
                    RunObject = page "Sales Order Archives";
                }
                action("Sales Return Order Archives")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Sales Return Order Archives';
                    RunObject = page "Sales Return List Archive";
                }
                action("Blanket Sales Order Archives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blanket Sales Order Archives';
                    RunObject = page "Blanket Sales Order Archives";
                }
                action(Action54)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action(Action86)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Opens the list of posted purchase credit memos.';
                }
                action(Action87)
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Opens the list of posted purchase return shipments.';
                }
                action(Action53)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Transfer Shipments")
                {
                    ApplicationArea = Location;
                    visible = false;
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page "Posted Transfer Shipments";
                    ToolTip = 'Open the list of posted transfer shipments.';
                }
                action("Posted Transfer Receipts")
                {
                    ApplicationArea = Location;
                    visible = false;
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipts";
                    ToolTip = 'Open the list of posted transfer receipts.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Issued Reminders';
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'Opens the list of issued reminders.';
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Basic, Suite;
                    visible = false;
                    Caption = 'Issued Finance Charge Memos';
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'Opens the list of issued finance charge memos.';
                }
            }

            group("Set ups")
            {
                action("transaction  types setup")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Transaction  types setup';
                    RunObject = page "TransactionTypePosting Setup";
                }
                action("No series")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'No series';
                    RunObject = page "Number Serires";
                }
                action("Plot setup")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Plots setup';
                    RunObject = page "Customer Posting Groups";
                }

                action("Investment Employers")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Investment Employers';
                    RunObject = page "Investment Employers";

                }
            }
        }
        area(creation)
        {
            action("Parcel Registration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Parcel Registration(Due Diligence)';
                Image = NewSalesQuote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Due Diligence List";
                RunPageMode = Create;
                ToolTip = 'Parcel registration DUe Diligence.';
            }
            action("Project Creation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Project Creation';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Project List";
                RunPageMode = Create;
                ToolTip = 'Create a new project.';
            }
            action("Investment Members")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Investment Members';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page Customers;
                RunPageMode = Create;
                ToolTip = 'Create a new investor.';
            }

            action("Plot Sale")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plot Sale';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Plots Application List";
                RunPageMode = Create;
                ToolTip = 'Sell a plot.';
            }


            action("Plot Receipting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Plot Receipting';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Receipts list-BOSA";
                RunPageMode = Create;
                ToolTip = 'Receipt a plot.';
            }
            action("Register Title Deed")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Register Title Deed';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Received Title Deed List";
                RunPageMode = Create;
                ToolTip = 'Register Title.';
            }
            action("Issue Title Deed")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Title Deed';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Title Processing List";
                RunPageMode = Create;
                ToolTip = 'Issue Title.';
            }
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';
                action("General Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journal';
                    Image = Journals;
                    RunObject = Page "General Journal";
                    ToolTip = 'Open a general journal where you can batch post  transactions to G/L, bank, customer, vendor and fixed assets accounts.';
                }
#if not CLEAN21
                action("Requests to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Requests to Approve';
                    Image = PriceWorksheet;
                    //RunPageView = WHERE("Object Type" = CONST(Page), "Object ID" = CONST(7023)); // "Sales Price Worksheet";
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Manage documents approvals.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '19.0';
                }
#else
                action("Price &Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    visible=false;
                    Caption = 'Price &Worksheet';
                    Image = PriceWorksheet;
                    RunObject = Page "Price Worksheet";
                    ToolTip = 'Opens the page where you can add new price lines manually or copy them from the existing price lists or suggest new lines based on data in the product cards.';
                }
#endif
            }
            group(Action42)
            {
                Caption = 'Sales';
#if not CLEAN21
                action("&Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Prices';
                    Image = SalesPrices;
                    RunPageView = WHERE("Object Type" = CONST(Page), "Object ID" = CONST(7002)); // "Sales Prices";
                    RunObject = Page "Role Center Page Dispatcher";
                    ToolTip = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the Sales Price Lists action.';
                    ObsoleteTag = '19.0';
                }
                action("&Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Line Discounts';
                    Image = SalesLineDisc;
                    RunPageView = WHERE("Object Type" = CONST(Page), "Object ID" = CONST(7004)); // "Sales Line Discounts";
                    RunObject = Page "Role Center Page Dispatcher";
                    ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the Sales Price Lists action.';
                    ObsoleteTag = '19.0';
                }
#else
                action("Price Lists")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Prices';
                    Image = SalesPrices;
                    RunObject = Page "Sales Price Lists";
                    ToolTip = 'View or set up sales price lists for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
#endif
            }
            group(Reports)
            {
                Caption = 'Reports';
                group(Customer)
                {
                    Caption = 'Customer';
                    Image = Customer;
                    action("Customer - &Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Order Summary';
                        Image = "Report";
                        RunObject = Report "Customer - Order Summary";
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer/&Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/&Item Sales';
                        Image = "Report";
                        RunObject = Report "Customer/Item Sales";
                        ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                    }
                }
                group(Action31)
                {
                    Caption = 'Sales';
                    Image = Sales;
                    action("Salesperson - Sales &Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson - Sales &Statistics';
                        Image = "Report";
                        RunObject = Report "Salesperson - Sales Statistics";
                        ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
                    }
#if not CLEAN21 
                    action("Price &List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Price &List';
                        Image = "Report";
                        RunPageView = WHERE("Object Type" = CONST(Report), "Object ID" = CONST(715)); // "Price List";
                        RunObject = Page "Role Center Page Dispatcher";
                        ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                        ObsoleteState = Pending;
                        ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                        ObsoleteTag = '19.0';
                    }
#else
                    action("Price &List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Price &List';
                        Image = "Report";
                        RunObject = Report "Item Price List";
                        ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                    }
#endif
                    action("Inventory - Sales &Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales &Back Orders';
                        Image = "Report";
                        RunObject = Report "Inventory - Sales Back Orders";
                        ToolTip = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.';
                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ShortCutKey = 'Ctrl+Alt+Q';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                }
            }
        }
    }

}