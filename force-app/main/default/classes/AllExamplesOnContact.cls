public class AllExamplesOnContact {
    //Set default phone & Email values if they are empty
    public static void setDefaultPhoneAndEmail(List<Contact> con){
        for(Contact c : con){
            if(c.Phone == null || c.Email == null){
                c.Phone = '999';
                c.Email = 'no@gmail.com';
            }
        }
    }
     //Count the number of contacts and store the value in Account
    public static void countNoOfContacts(list<Contact> con){
        set<id> conIds = new set<id>();
        for(Contact c : con){
            if(c.AccountId != null){
                conIds.add(c.AccountId);
            }
        }
        list<Account> acc = [SELECT id, (SELECT id from Contacts) From Account Where Id In : conIds];
        for(Account a : acc){
            a.Number_of_Contacts__c = a.Contacts.size();
        }
        update acc;
    }
    //If Lead source is web in contact, create opportunity
    public static void createOpp(list<Contact> con){
        list<Opportunity> opp = new list<Opportunity>();
        for(Contact c : con){
            if(c.LeadSource == 'Web'){
                Opportunity p = new opportunity();
                p.AccountId = c.AccountId;
                p.Name = 'New Opportunity';
                p.CloseDate = date.valueOf('2023-07-4');
                p.StageName = 'Prospecting';
                p.Type = 'New Customer';
                
                opp.add(p);
            }
        }
        insert opp;
    }
}