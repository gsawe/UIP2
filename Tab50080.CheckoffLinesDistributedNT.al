//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50080 "Checkoff Lines-Distributed-NT"

{

    fields
    {
        field(1; "Payroll No"; Code[20])
        {
        }
        field(2; "Employee Name"; Text[150])
        {
        }
        field(3; "Member No"; Code[30])
        {
        }
        field(4; "Checkoff No"; Code[40])
        {
        }
        field(5; Deposits; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; DL_P; Decimal)
        {
        }
        field(7; DL_I; Decimal)
        {
        }
        field(8; NL_P; Decimal)
        {
        }
        field(9; NL_I; Decimal)
        {
        }
        field(10; EMER_P; Decimal)
        {
        }
        field(11; EMER_I; Decimal)
        {
        }
        field(12; DeFL_P; Decimal)
        {
        }
        field(13; DeFL_I; Decimal)
        {
        }
        field(14; MVL_P; Decimal)
        {
        }
        field(15; MVL_I; Decimal)
        {
        }
        field(16; INSURANCE; Decimal)
        {
        }
        field(17; "Dependand Savings 1"; Decimal)
        {
        }
        field(18; "Dependand Savings 2"; Decimal)
        {
        }
        field(19; BENEVOLENT; Decimal)
        {
        }
        field(20; SAdvanceL_P; Decimal)
        {
        }
        field(21; SAdvanceL_I; Decimal)
        {
        }
        field(22; DhamanaL_P; Decimal)
        {
        }
        field(23; DhamanaL_I; Decimal)
        {
        }
        field(24; HarakaL_P; Decimal)
        {
        }
        field(25; HarakaL_I; Decimal)
        {
        }
        field(26; SHARES; Decimal)
        {
        }
        field(27; TOTAL_DISTRIBUTED; Decimal)
        {
            FieldClass = Normal;
        }
        field(28; "ID No"; Code[20])
        {
        }
        field(29; HouseHL_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; HouseHL_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; JumboL_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; JumboL_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "VS-MEMBER"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; DL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; EL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; IL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; MSL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; SL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; SPL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; SSL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; TL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "DL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "EL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "IL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "MSL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "SL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "SPL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "SSL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "TL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "TL1_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "SSPL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; TL1_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; TL1_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; REGFEE; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; SAD; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; SAI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "SpecialL_P"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "SpecialL_I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "PremiumL-P"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "PremiumL-I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Dependand Savings 3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "JUNIOR SAVINGS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "SACCO PREMIUM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; SHARECAP; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "VSMEMBER_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Benevolent Fund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "SuperSL_P"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "SuperSL_I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "SchoolF_P"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(71; "SchoolF_I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Holiday Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; Mavuno_L; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Mavuna_I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Utafiti Housing"; Decimal) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(Key1; "Payroll No", "Checkoff No")
        {
            Clustered = true;
        }
        // key(key2; "Member No", "Payroll No", "Checkoff No")
        // {
        //     //Clustered = true;
        // }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;

}




