public class AllExamplesOnAcount {
    //If Rating is hot create contact
    public static void RatingIsHotCreateContact(list<Account> acc){
        list<Contact> con = new List<Contact>();
        for(Account a : acc){
            if(a.Rating == 'Hot'){
                Contact c = new Contact();
                c.LastName = 'New Contact';
                c.AccountId = a.Id;
                c.Phone = '98765432';
               
                con.add(c);
            }
        }
        insert con;
    }
    //create opportunity if rating is warm.
    public static void RatingIsWarmCreateOpportunity(list<Account> acc){
        list<Opportunity> op = new list<Opportunity>();
        for(Account a : acc){
            if(a.Rating == 'Warm'){
                opportunity p = new opportunity();
                p.AccountId = a.id;
                p.Name = 'New opportunity';
                p.StageName = 'Qualification';
                p.CloseDate = Date.valueOf('2023-06-18');
                
                op.add(p);
            }
        }
        insert op;
    }
    
    //Update Description field with user first name and last name
    public static void updateDescription(list<Account> acc){
        for(Account a : acc){
            if(a.Description == null){
                a.Description = userInfo.getFirstName() + userinfo.getLastName();
            }
        }
    }
   	//Prevent user to delete the account if Account has more than 2 Opportunities
    public static void checkOpp(list<Account> acclist){
        set<id> Accids = new set<id>();
        for(Account acc : acclist){
            Accids.add(acc.Id);
        }
        list<Account> accOpp = [SELECT id, (Select Id from opportunities) from Account Where Id IN :Accids];
        for(Account a : accOpp){
            if(a.Opportunities.size()>2){
                a.addError('You cannot delete this account it has related Opportunities');
            }
        }
    }
    //If Account rating is hot update opportunity description with account description
    public static void checkRating(list<Account> acc){
        set<id> accids = new set<id>();
        for(Account a : acc){
            if(a.Rating == 'Hot'){
                accids.add(a.Id);
            }
        }
        list<Account> alist = [Select Description, (Select Description From opportunities) From Account where Id IN : accids];
        list<opportunity> oplist = new list<opportunity>();
        for(Account ad : alist){
            for(opportunity opp: ad.opportunities){
                opp.Description = ad.Description;
                oplist.add(opp);
            }
        }
        update oplist;
    }
    //If Account Rating is cold update contact Description
    public static void updatecontact(list<Account> acclist){
        set<id> accids = new set<id>();
        for(Account a : acclist){
            if(a.Rating == 'Cold'){
                accids.add(a.id);
            }
        }
        list<Contact> con = [Select Id,Description,AccountId from Contact where AccountId IN : accids];
        list<Contact> c = new list<Contact>();
        for(Account acc : acclist){
            for(Contact cid : con){
                if(cid.AccountId == acc.Id){
                    cid.Description = acc.Description;
                    c.add(cid);
                }
            }
         update c;  
        }
    }
}