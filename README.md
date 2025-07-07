# PayFlex – Request to Pay System

PayFlex is a modular, full-stack simulation platform for real-time digital payments. It is developed using Spring Boot (backend) and ReactJS (frontend), supporting seamless interactions between administrators, merchants, and customers through QR-based and manual payment flows.

## System Architecture

```
PayFlex-App/
│
├── payflex-backend/           # Spring Boot backend API
├── payflex-frontend/          # Customer-facing web app
├── payflex-merchant-portal/   # Merchant dashboard
├── payflex-mms/               # Admin dashboard (MMS)
├── .github/                   # GitHub Actions workflows
├── .gitmodules                # Git submodule references (if used)
├── settings.xml               # Maven settings (optional)
├── README.md                  # This file
```

## Live Deployments

- Customer App: https://payflex-app.fatima-jamal.com  
- Merchant Portal: https://payflex-merchant-portal.fatima-jamal.com/login  
- MMS Admin Panel: https://payflex-mms.fatima-jamal.com  

## Repositories

- Backend: [payflex-backend](https://github.com/Fatima-jamal/payflex-backend)
- Merchant Portal: [payflex-merchant-portal](https://github.com/Fatima-jamal/payflex-merchant-portal)
- Customer App: [payflex-frontend](https://github.com/Fatima-jamal/payflex-frontend)
- Merchant Management System (MMS): [payflex-mms](https://github.com/Fatima-jamal/payflex-mms)

## Tech Stack

| Layer       | Technologies                 |
|-------------|------------------------------|
| Frontend    | ReactJS, Axios, CSS Modules  |
| Backend     | Spring Boot 3, Java 17       |
| Database    | PostgreSQL, Spring Data JPA  |
| Deployment  | Netlify, GitHub Actions      |
| Dev Tools   | Postman, DBeaver, Ngrok      |

## Setup Instructions

### Backend (Spring Boot)
```
cd payflex-backend
mvn clean install
mvn spring-boot:run
```

### Frontend (ReactJS)
```
cd payflex-frontend           # or payflex-merchant-portal or payflex-mms
npm install
npm run dev
```

Update `.env` in each frontend with:
```
REACT_APP_API_URL=http://localhost:8081
```

## CI/CD

GitHub Actions are configured for:
- Spring Boot backend: Maven build, test
- ReactJS frontend: Build verification
- Future production deployment (via Netlify or reverse proxy)

## License

© 2025 Fatima Jamal – All rights reserved.
