<h1 align="center">
  </br></br>Ring of Reciprocity
</h1>
<p align="center">
  </br>
  <b>
    #=================================================================#</br>
    Empowering Volunteers, Transforming Communities
    #=================================================================#</br>
  </b> </br></br>
  Brought to you by Voiceserve. In collaboration with Gebirah.</br></br>
  More detailed information can be found on our <a href="https://sites.google.com/mymail.sutd.edu.sg/voiceserve/">website</a>
</p>




## Introduction

Our web application was developed in collaboration with **Gebirah**, a global humanitarian and social initiative, to address two key problems:  
1) Easing the burden on the sandwich generation  
2) Addressing the shortage of volunteers at charities by leveraging the Corporate Volunteer Scheme (CVS)

## What is the Sandwich Generation and Why Do They Need Help?

The "sandwich generation" refers to adults who are simultaneously caring for their aging parents and supporting their own children. This dual caregiving role often leads to significant financial, emotional, and physical stress due to the competing demands of both generations. This phenomenon is increasingly common in Singapore, where individuals start to neglect their own well-being and aspirations. Providing even simple support can significantly alleviate their stress and improve their welfare.

## What is the Corporate Volunteer Scheme?

The Corporate Volunteer Scheme (CVS), initiated by the Inland Revenue Authority of Singapore, encourages corporate volunteerism by allowing businesses to claim a 250% tax deduction on expenditure incurred when they send their employees to volunteer at Institutions of a Public Character (IPCs).  
[Learn more about the CVS](https://www.iras.gov.sg/taxes/corporate-income-tax/income-deductions-for-companies/business-expenses/corporate-volunteer-scheme).

## App Purpose

This app aims to incentivize more people to volunteer and help the community by:  
1) Facilitating connections between overwhelmed individuals and volunteers  
2) Improving accessibility for businesses to participate in the CVS

By simplifying the process for companies to engage in the CVS, we aim to maximize the benefits of the scheme and encourage more corporate volunteers. Additionally, by creating a convenient platform for easy connections between individuals in need of help and those willing to volunteer, we hope to reduce the barriers to volunteering, thereby encouraging more participation.

## Features

### General Public

Interested in getting help with some errands? Looking to volunteer for a cause you believe in? Look no further—our app is here to link you up! The following features apply to all accounts registered on **Ring Of Reciprocity**.

#### Requests

1) **Make a Request**: Easily create a request for help with errands or other tasks.  
2) **View Applicants**: See who has applied to help with your request.  
3) **Accept/Reject Applicants**: Choose the most suitable applicant or politely decline others.  
4) **Chat**: Communicate directly with applicants to coordinate details.

#### Applications

1) **View Requests on Home Page**: Browse available requests from others.  
2) **View Request Details**: Get more information about the request before applying.  
3) **Apply for Request**: Offer your help by applying to a request.  
4) **Get Notified When You Have Been Accepted**: Receive notifications when your application is accepted.  
5) **Chat**: Communicate with the requester to finalize details.

#### Chats

View all chats you have with other users, whether you are an applicant or a requester.

#### Profile

Manage your account, view your chat history, and monitor your activities as an applicant or requester.

#### What if I Notice an Inappropriate Request or User?

We have a reporting system in place to handle inappropriate requests or users. You can easily flag any content or user behavior that you believe violates community guidelines.

### Corporate

Interested in trying out the new Corporate Volunteer Scheme to support charities around Singapore and claim tax benefits? If so, these additional features are for you!

#### Corporate Volunteers

Designed for employees of businesses and companies to get involved in volunteer work.

#### Corporate Volunteer Manager

Allows you to make applications on behalf of your company, ensuring that your volunteer efforts align with the CVS guidelines.

### Charities

Are you a charity looking for more volunteers to help out? This is the place for you!

#### Create Requests

Post volunteer opportunities that align with your organization's needs and attract corporate volunteers through the platform.

## Design Journey and Iteration

### Sprint 1

**Deploying to the Cloud**  
- Set up the basic backend and frontend framework.

**Features Delivered**  
- **Requests Page**: A functional requests page was created, laying the foundation for user interactions.

### Sprint 2

**Basic User Story**  
- Expanded on user interactions and functionality.

**Features Delivered**  
- **Application**: Users can now apply to requests.
- **New Requests**: Introduced the ability for users to create new requests.
- **My Requests**: Added functionality for users to manage their requests:
  - **Accept**: Accept applicants for requests.
  - **Reject**: Reject applicants.
- **Reviews**: Users can now leave reviews for completed requests.

### Sprint 3

**Finished Basic User Story**  
- Continued enhancing user interactions with additional features.

**Code Coverage**  
- **Cucumber + RSpec**: Implemented code coverage using Cucumber and RSpec to ensure robust testing.

**Features Delivered**  
- **Chat**: Introduced a chat feature for users to communicate directly.
- **Edit Profile**: Users can now edit their profiles.
- **AI Match Percentage**: Implemented an AI-driven match percentage to help users find the most suitable volunteers or requests.

### Sprint 4

**More User Stories**  
- Focused on expanding roles and functionalities within the app.

**Features Delivered**  
- **Charity**: Added features to support charity users in managing volunteer requests.
- **Admin**: Introduced admin functionalities:
  - **Ban/Unban Users**: Admins can manage user access by banning or unbanning users.
- **Corporate Volunteer**: Expanded features for corporate volunteers to engage in the CVS.
- **Corporate Manager**: Added functionalities for corporate managers to oversee volunteer activities.
- **Report Users**: Introduced a reporting feature for users to report inappropriate behavior or requests.

## Software Architecture

### Server Architecture
![Server Architecture](https://github.com/user-attachments/assets/1ad1face-bdc0-46e4-b7b7-cfc01b450a89)


This diagram illustrates the overall structure of our server, showing how different components interact with each other to deliver the core functionalities of our application.

### Use Case Diagram
![Use Case Diagram](https://github.com/user-attachments/assets/ae4dfa12-ee10-4bc1-a8b9-6bf7ebbee1e1)

The use case diagram highlights the various actors involved in the system and the interactions they have with the system to accomplish specific tasks.

### ER Diagram
![ER Diagram](https://github.com/user-attachments/assets/5e309d2a-e4fa-4be9-ae94-c40e70093802)

The ER diagram represents the data model of the application, showing the relationships between entities such as users, requests, applications, and notifications.

### Class Diagram
![Class Diagram](https://github.com/user-attachments/assets/8c82c787-f286-4d25-afef-27a4742e312c)

The class diagram provides a detailed view of the structure of the application's codebase, depicting classes, their attributes, methods, and the relationships between them.

## RESTful Routes

### Authentication
- **GET /login**: Gets the login page.
- **POST /login**: Submits credentials to the server for authentication.
- **GET /register**: Gets the register page.
- **POST /register**: Submits details for a new account.
- **GET /register/corporate**: Gets the corporate register page.
- **POST /register/corporate**: Submits details for a new company.
- **GET /register/charity**: Gets the charity register page.
- **POST /register/charity**: Submits details for a new charity.
- **GET /register/charitysuccess**: Displays the success page upon registering as a charity.
- **GET /register/corporatesuccess**: Displays the success page upon registering as a company.

### Requests
- **GET /requests**: Gets the request page with all available requests.
- **POST /requests**: Creates a new request with submitted details.
- **GET /requests/new**: Shows the create new request page.
- **POST /requests/apply**: Applies for a new request.
- **GET /requests/:id/edit**: Gets the edit request page.
- **PATCH /requests/:id**: Updates request details.
- **DELETE /requests/:id**: Deletes a request.

### CVM Dashboard
- **GET /cvm**: Gets and displays the CVM dashboard.
- **GET /cvm/charities**: Gets and displays the available and associated charities.
- **PATCH /cvm/charities/update**: Updates the list of charities under the company.
- **GET /cvm/employees**: Gets and displays a list of all employees under the company.
- **PATCH /cvm/employees/deactivate**: Deactivates an employee's account.
- **PATCH /cvm/employees/activate**: Activates an employee's account.
- **POST /cvm/summaryreport**: Generates a summary report about the company’s statistics in CSV format, given a date range.
- **POST /cvm/generatenew**: Generates a new code for the company for employees.

### My Requests
- **GET /myrequests**: Gets requests created by the current user.
- **POST /myrequests/complete**: Marks a request as completed.
- **POST /myrequests/accept**: Accepts an application for a given request.
- **POST /myrequests/reject**: Rejects an application for a given request.

### My Applications
- **GET /myapplications**: Gets and shows all applications made by the current user.
- **POST /myapplications/withdraw**: Withdraws an application for a given request.

### Reviews
- **POST /reviews**: Posts a new review as an applicant or a volunteer.
- **GET /reviews/new**: Gets the form for creating a new review.

### Notifications
- **POST /notifications/read**: Marks a notification as read.
- **POST /notifications/clear**: Clears all notifications given a user ID.

### Report User
- **GET /new_reports/new**: Gets and displays a new report form.
- **GET /confirm_report**: Gets and displays a form to create a confirm report.
- **POST /user_reports**: Creates a new user report.
- **POST /user_reports/confirm**: Confirms a report by ID.

### Chats
- **GET /chats**: Gets all chats relating to the currently logged-in user.
- **POST /chats/:id/messages**: Sends a message to the given chat.

### Approve/Reject Charities
- **GET /admin/charities**: Gets and displays charities that seek status change.
- **GET /admin/charities/:id**: Gets and displays the charity by ID.
- **PATCH /admin/charities/:id/approve**: Updates the approve status of the charity by ID.
- **PATCH /admin/charities/:id/disable**: Updates the disable status of the charity by ID.
- **PATCH /admin/charities/:id/reject**: Updates the reject status of the charity by ID.

### Approve/Reject Companies
- **GET /admin/approve_companies**: Gets and displays companies that seek status change.
- **GET /admin/approve_companies/:id**: Gets and displays the company by ID.
- **PATCH /admin/approve_companies/:id/approve**: Updates the approve status of the company by ID.
- **PATCH /admin/approve_companies/:id/disable**: Updates the disable status of the company by ID.
- **PATCH /admin/approve_companies/:id/reject**: Updates the reject status of the company by ID.

### Ban/Unban User
- **GET /admin/ban_user**: Gets and displays users that are reported.
- **POST /admin/ban_user/:id/ban**: Bans the user by ID.
- **POST /admin/ban_user/:id/unban**: Unbans the user by ID.
- **POST /admin/ban_user/:id/cancel**: Cancels a report on the user by ID.

## Links

- [Design Workbook](https://docs.google.com/document/d/1km712efr3sV3mpAjT-HVZJt_zmfZK7F16ZBitiOpfhI/edit?usp=sharing)
- [Figma Board - All User Journey, Notes, etc.](https://www.figma.com/board/dMNnE6Neq7AkP9adNt3O0Q/Week-2-SDS?node-id=0-1&t=nsbPixMsvbBCgWNg-1)
- [Figma High Fidelity Prototype](https://www.figma.com/design/F0aIoDhpwWwPJcyd9I017f/Requests-Page?node-id=0-1&t=nNrMNE4wWPV6U9JM-1)

## Product Video

Check out our [Product Video](https://youtu.be/f2WvkDOaWNc) to see the platform in action!
