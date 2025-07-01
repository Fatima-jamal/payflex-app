@startuml
skinparam backgroundColor white
skinparam shadowing false

skinparam rectangle {
  BackgroundColor #ffffff
  BorderColor #000000
  FontColor #000000
}
skinparam defaultFontColor #000000

skinparam node {
  BackgroundColor white
  BorderColor #000000
}
skinparam database {
  BackgroundColor white
  BorderColor #000000
}

left to right direction
title <b>PayFlex System Architecture</b>

' Define layers as frames
frame "Web Layer" {
  rectangle "Customer App\nWeb Application" as Customer
  rectangle "Merchant Portal\nWeb Application" as Portal
  rectangle "MMS\nWeb Application" as MMS
}

frame "Application Layer" {
  rectangle "REST API\n(Spring Boot Controllers)" as API
  rectangle "Spring Boot Application\n(Business Logic)" as Backend
}

frame "Data Layer" {
  database "PostgreSQL\nShared Database" as DB
}

' Connections
Customer --> API
Portal --> API
MMS --> API

API --> Backend
Backend --> DB

@enduml


@startuml
skinparam backgroundColor white
skinparam shadowing false
skinparam defaultFontColor black
skinparam sequence {
  ArrowColor black
  LifeLineBorderColor black
  LifeLineBackgroundColor #f5f5f5
  ParticipantBorderColor black
  ParticipantBackgroundColor white
}

title <b>PayFlex Technologies & Tools – Dev & Runtime Workflow</b>

actor Developer

participant "VS Code\n(React Frontend Dev)" as VSCode
participant "IntelliJ IDEA\n(Spring Boot Backend Dev)" as IntelliJ
participant "GitHub\n(Version Control)" as GitHub
participant "Postman\n(API Testing)" as Postman
participant "Spring Boot App\n(Backend Service)" as Backend
participant "ReactJS App\n(Customer / Merchant / MMS)" as Frontend
database "PostgreSQL\nDatabase" as DB

== Development Workflow ==
Developer -> VSCode : Write React code
Developer -> IntelliJ : Write Java code (Spring Boot)
Developer -> GitHub : Push frontend/backend code
VSCode -> GitHub : Push React app
IntelliJ -> GitHub : Push backend code
GitHub -> GitHub : Run GitHub Actions (build/test) [planned]

== Testing Workflow ==
Developer -> Postman : Send API requests with JWT
Postman -> Backend : Test /api/payment-requests
Backend -> DB : Read/Write data
DB --> Backend
Backend --> Postman : JSON response

== Runtime Behavior ==
Frontend -> Backend : HTTP call to REST endpoint
Backend -> DB : Fetch/insert/update data
DB --> Backend
Backend --> Frontend : Success or error response

@enduml
