@isTest
public class AccountHelperTest {
    @isTest
    static void testGetAccountsByEmployeeCount() {
        // Create test data
        Account acc1 = new Account(Name = 'Test Account 1', NumberOfEmployees = 50);
        Account acc2 = new Account(Name = 'Test Account 2', NumberOfEmployees = 10);
        insert new List<Account>{ acc1, acc2 };

        // Call the method and assert results
        List<Account> results = AccountHelper.getAccountsByEmployeeCount(20);
        System.assertEquals(1, results.size());
        System.assertEquals('Test Account 1', results[0].Name);
    }

    @isTest
    static void testUpdateAccountIndustries() {
        // Create test data
        Account acc1 = new Account(Name = 'Test Account 1', Industry = 'Technology');
        Account acc2 = new Account(Name = 'Test Account 2', Industry = 'Finance');
        insert new List<Account>{ acc1, acc2 };

        // Update industries
        AccountHelper.updateAccountIndustries(new List<Id>{ acc1.Id, acc2.Id }, 'Healthcare');

        // Query and assert updates
        List<Account> updatedAccounts = [SELECT Industry FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
        for (Account acc : updatedAccounts) {
            System.assertEquals('Healthcare', acc.Industry);
        }
    }
}