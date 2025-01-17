public class ContactManager {
    // Method to fetch contacts for a specific account
    public static List<Contact> getContactsByAccount(Id accountId) {
        try {
            // Query to fetch all contacts for the given account
            return [SELECT Id, FirstName, LastName, Email 
                    FROM Contact 
                    WHERE AccountId = :accountId];
        } catch (Exception e) {
            // Log error if query fails
            System.debug('Error fetching contacts: ' + e.getMessage());
            return new List<Contact>();
        }
    }

    // Method to update the email domain for a list of contacts
    public static void updateContactEmailDomain(List<Id> contactIds, String newDomain) {
        try {
            // Fetch the contacts to update
            List<Contact> contactsToUpdate = [SELECT Id, Email 
                                              FROM Contact 
                                              WHERE Id IN :contactIds AND Email != NULL];
            // Update the email field
            for (Contact con : contactsToUpdate) {
                String[] emailParts = con.Email.split('@');
                if (emailParts.size() == 2) {
                    con.Email = emailParts[0] + '@' + newDomain;
                }
            }
            // Perform DML update
            update contactsToUpdate;
            System.debug('Successfully updated contact email domains.');
        } catch (Exception e) {
            // Log error if update fails
            System.debug('Error updating contact emails: ' + e.getMessage());
        }
    }
}