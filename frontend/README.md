# BelicusDB - Frontend Instructions

## Overview
This frontend application provides a comprehensive interface for managing military conflicts data with the following features:

### Features Implemented:

#### A. Registration Forms
- **Conflicts**: Register military conflicts with type, casualties data
- **Military Groups**: Register armed groups with casualty tracking
- **Divisions**: Register divisions within military groups with equipment and personnel data
- **Political Leaders**: Register leaders associated with military groups
- **Military Chiefs**: Register military chiefs with hierarchical information

#### B. Statistics & Reports
1. **Conflict Type Histogram**: Interactive chart showing distribution of conflicts by type
2. **Arms Dealers Report**: Lists dealers and groups for specific weapons (Barrett M82, M200 Intervention)
3. **Top 5 Deadliest Conflicts**: Ranking by casualty numbers
4. **Top 5 Mediation Organizations**: Organizations with most mediations
5. **Top 5 Armed Groups by Weapons**: Groups with most weapons supplied
6. **Religious Conflicts by Country**: Countries with most religious conflicts

## How to Run

### Prerequisites
- Backend server running on `http://localhost:8000`
- Modern web browser with JavaScript enabled

### Setup
1. Ensure the Django backend is running
2. Open `index.html` in a web browser or serve via HTTP server
3. Navigate through the tabs: Cadastros (Registration), Estatísticas (Statistics), Relatórios (Reports)

### Usage Guide

#### Registration Tab
- Fill out forms and click submit buttons
- Forms include validation and will show success/error messages
- Group dropdowns are automatically populated when groups are created

#### Statistics Tab
- Click "Carregar Gráfico" to load the conflict type histogram
- Interactive chart shows conflict distribution by type

#### Reports Tab
- Click on any report button to load data
- Tables display formatted results from backend queries
- Reports include various analytics as specified in requirements

### API Integration
The frontend connects to these backend endpoints:
- `POST /api/conflitos/` - Create conflicts
- `POST /api/grupos/` - Create military groups  
- `POST /api/divisoes/` - Create divisions
- `POST /api/lider-politico/` - Create political leaders
- `POST /api/chefe-militar/` - Create military chiefs
- `GET /api/estatisticas/tipo-conflito/` - Conflict type statistics
- `GET /api/estatisticas/arma-traficante/` - Arms dealer data
- `GET /api/estatisticas/top-conflitos-mortos/` - Top deadly conflicts
- `GET /api/estatisticas/top-organizacoes/` - Top organizations
- `GET /api/estatisticas/top-grupos-armas/` - Top armed groups
- `GET /api/estatisticas/pais-religiosos/` - Religious conflicts by country

### Design Features
- Modern gradient UI with glassmorphism effects
- Responsive Bootstrap layout
- Interactive charts using Chart.js
- Smooth animations and hover effects
- Error handling with user feedback
- Form validation and loading states

### Troubleshooting
- Ensure backend is running on port 8000
- Check browser console for JavaScript errors
- Verify CORS settings in Django backend if needed
- All forms require backend connection to function
