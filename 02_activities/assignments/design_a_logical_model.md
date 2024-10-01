# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Two Architectures for the CUSTOMER_ADDRESS Table
Type 1 vs. Type 2 Slowly Changing Dimensions:

Type 1: Overwrites the existing data and doesn't retain historical changes.
Type 2: Retains historical changes by creating a new row each time the address changes.
Architecture 1 (Type 1 - Overwrites Address)
In a Type 1 architecture, the customer’s address is updated in place, meaning that any new address simply overwrites the old one without preserving the previous address history. This method is simple and uses less storage but loses the historical information of previous addresses.

CUSTOMER_ADDRESS Table for Type 1:
Column Name	Data Type	Description
customer_id	INT (PK, FK)	Unique ID for each customer
address_line1	VARCHAR(100)	Street address
address_line2	VARCHAR(100)	Additional address information (e.g., Apt #)
city	VARCHAR(50)	City of the customer
state	VARCHAR(50)	State of the customer
zip_code	VARCHAR(10)	Postal/zip code
country	VARCHAR(50)	Country of the customer
Behavior: When a customer's address changes, the new address simply overwrites the existing values for address_line1, city, etc.
Pro: Simpler and efficient in terms of storage and processing.
Con: You lose historical information about a customer's past addresses.
Architecture 2 (Type 2 - Retains Historical Changes)
In a Type 2 architecture, we store each change in a new row, along with effective dates to keep track of when an address was valid. This method preserves a complete history of address changes, allowing you to track the evolution of a customer’s location over time.

CUSTOMER_ADDRESS Table for Type 2:
Column Name	Data Type	Description
customer_id	INT (FK)	Unique ID for each customer
address_id	INT (PK)	Unique ID for each address record
address_line1	VARCHAR(100)	Street address
address_line2	VARCHAR(100)	Additional address information (e.g., Apt #)
city	VARCHAR(50)	City of the customer
state	VARCHAR(50)	State of the customer
zip_code	VARCHAR(10)	Postal/zip code
country	VARCHAR(50)	Country of the customer
effective_start	DATE	Start date when the address became active
effective_end	DATE	End date when the address was no longer valid
Behavior: Every time a customer’s address changes, a new record is added to the table with the new address and the effective start date. The previous address's effective_end is updated to indicate when it was no longer valid.
Pro: Preserves historical records, providing a full timeline of address changes.
Con: More complex and requires more storage and processing to manage historical data.
Which is Type 1 and Type 2?
Architecture 1 is a Type 1 Slowly Changing Dimension because it overwrites the previous data and does not retain historical information.
Architecture 2 is a Type 2 Slowly Changing Dimension because it retains historical records by adding new rows for each change and keeping track of address validity over time.
Privacy Implications
Type 2 (retaining historical data) raises potential privacy concerns, as it stores previous addresses indefinitely, which may contain sensitive personal information. Retaining past addresses could expose more about a person’s location history if data is accessed or misused.

Mitigation: It's crucial to implement strong data protection measures (e.g., encryption, access control) and possibly consider data retention policies that remove or anonymize old data after a set period.
Type 1 (overwriting data) presents fewer privacy risks because it only keeps the most current address on file, reducing the amount of personal data stored over time.

Both architectures require data security policies and compliance with data protection regulations (e.g., GDPR) to ensure that personal information is handled responsibly and transparently.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
 There are two key differences compared to the bookstore's ERD that we previously discussed:

1. Use of Multiple Schemas
AdventureWorks uses multiple schemas to logically separate different parts of the database. For instance, it has schemas like HumanResources, Sales, and Production, which organize tables by their functional area.

In the bookstore ERD, everything was placed into one schema, meaning tables like employee, order, customer, etc., are all part of the same group.

Potential Change: While the bookstore ERD is simpler and more manageable for a small business, adopting the practice of schemas could add better logical separation if the business grows. For example:

HumanResources schema for employee-related tables.
Sales schema for customer and order data. This would make the database easier to maintain if the system expands.
2. Customer Contact Information
AdventureWorks splits customer contact information into separate entities. There is a Person table that contains general information, and a separate EmailAddress table linked to it. This allows for flexibility in associating multiple email addresses with a single customer.

In the bookstore ERD, customer contact details (like address and possibly email) are stored directly in the customer or customer_address table.

Potential Change: If the bookstore needs to support multiple contact methods (like different addresses or email addresses for the same customer), it might be wise to follow the AdventureWorks pattern and store such details in separate tables. This would improve data normalization and flexibility in managing customer records.

Would You Change Anything in Your ERD?
Multiple Schemas: If the bookstore is small and manageable, it might not need multiple schemas. However, if we anticipate growth, it would be beneficial to separate concerns (e.g., employee and sales data) into schemas to enhance maintainability.

Customer Contact Info: Following the AdventureWorks model, I would consider splitting customer contact information into separate tables. For instance, creating a Customer_Contact table with phone numbers and emails, allowing flexibility for multiple contacts. Similarly, adding a separate Customer_Address table would allow for keeping multiple addresses (home, work, etc.) for each customer.

These changes would lead to better scalability and a more flexible design for future expansion.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
