import { LightningElement, wire, api } from 'lwc';
import GET_CONTACTS from '@salesforce/apex/ContactController.getContact';
import CONTACT from '@salesforce/schema/Contact';
export default class ContactsAccordion extends LightningElement {
    @api recordId;
    objectApiName = CONTACT.objectApiName;
    contacts = [];
    contactsExist = true;
    @wire(GET_CONTACTS, { accountId: '$recordId' })
    getContacts({ data, error }) {
        if (data) {
            if (data.length == 0) {
                this.contactsExist = false;
                console.log(this.contactsExist);
            }
            this.contacts = data;
        }
        if (error) {
            console.error(error);
        }
    }
}