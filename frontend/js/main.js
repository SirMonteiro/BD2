document.addEventListener('DOMContentLoaded', () => {
    const apiBase = 'http://localhost:8000/api';
    let chart = null;

    // Load groups for division form
    loadGroups();

    // Generic function to handle form submission
    async function handleFormSubmit(formId, endpoint, dataBuilder, successMessage = 'Cadastro realizado com sucesso!') {
        const form = document.getElementById(formId);
        if (!form) return;
        
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const data = dataBuilder();
            try {
                const res = await fetch(`${apiBase}/${endpoint}/`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data),
                });
                if (res.ok) {
                    alert(successMessage);
                    form.reset();
                    // Reload groups if we added a new group
                    if (endpoint === 'grupos') {
                        loadGroups();
                    }
                } else {
                    const errorData = await res.text();
                    alert(`Erro ao cadastrar: ${errorData}`);
                }
            } catch (error) {
                console.error('Erro:', error);
                alert('Erro de conexão. Verifique se o backend está rodando.');
            }
        });
    }

    // Load groups for division dropdown
    async function loadGroups() {
        try {
            const res = await fetch(`${apiBase}/grupos/`);
            if (res.ok) {
                const groups = await res.json();
                
                // Update all group select elements
                const selects = ['grupoSelect', 'grupoLiderSelect', 'codigoLiderChefe', 'grupoDivisao'];
                selects.forEach(selectId => {
                    const select = document.getElementById(selectId);
                    if (select) {
                        select.innerHTML = '<option value="">Selecione um grupo...</option>';
                        groups.forEach(group => {
                            const option = document.createElement('option');
                            option.value = group.codigo;
                            option.textContent = group.nome;
                            select.appendChild(option);
                        });
                    }
                });
            }
        } catch (error) {
            console.error('Erro ao carregar grupos:', error);
        }
    }

    // Register conflict
    handleFormSubmit('conflitoForm', 'conflitos', () => ({
        nome: document.getElementById('nomeConflito').value,
        tipo_conf: document.getElementById('tipoConflito').value,
        nr_mortos: parseInt(document.getElementById('nrMortos').value) || 0,
        nr_feridos: parseInt(document.getElementById('nrFeridos').value) || 0,
    }));

    // Register group
    handleFormSubmit('grupoForm', 'grupos', () => ({
        nome: document.getElementById('nomeGrupo').value,
        soma_baixas: parseInt(document.getElementById('somaBaixas').value) || 0,
    }));

    // Register division
    handleFormSubmit('divisaoForm', 'divisoes', () => ({
        codigo_grupo: document.getElementById('grupoSelect').value,
        nr_avioes: parseInt(document.getElementById('nrAvioes').value) || 0,
        nr_tanques: parseInt(document.getElementById('nrTanques').value) || 0,
        nr_barcos: parseInt(document.getElementById('nrBarcos').value) || 0,
        nr_membros: parseInt(document.getElementById('nrMembros').value) || 0,
        nr_baixas: parseInt(document.getElementById('nrBaixas').value) || 0,
    }));

    // Register political leader
    handleFormSubmit('liderPoliticoForm', 'lider-politico', () => ({
        codigo_grupo: document.getElementById('grupoLiderSelect').value,
        nome_lider: document.getElementById('nomeLiderPolitico').value,
        apoios: document.getElementById('apoiosLider').value || '',
    }));

    // Register military chief
    handleFormSubmit('chefeMilitarForm', 'chefe-militar', () => ({
        faixa_hierarquica: document.getElementById('patente').value,
        nome_lider: document.getElementById('nomeLiderChefe').value,
        codigo_lider: document.getElementById('codigoLiderChefe').value,
        numero_divisao: parseInt(document.getElementById('numeroDivisao').value),
        grupo_divisao: document.getElementById('grupoDivisao').value,
    }));

    // Chart functionality

    const getGrafico = async () => {
        try {
                const res = await fetch(`${apiBase}/estatisticas/tipo-conflito/`);
                if (res.ok) {
                    const data = await res.json();
                    createChart(data);
                } else {
                    alert('Erro ao carregar dados do gráfico');
                }
            } catch (error) {
                console.error('Erro:', error);
                alert('Erro de conexão. Verifique se o backend está rodando.');
            }
    }

    const carregarGraficoBtn = document.getElementById('carregarGrafico');
    const estatisticasBtn = document.getElementById('estatisticas-tab');
    if (carregarGraficoBtn || estatisticasBtn) {
        carregarGraficoBtn.addEventListener('click', getGrafico);
        estatisticasBtn.addEventListener('click', getGrafico);
    }

    function createChart(data) {
        const ctx = document.getElementById('graficoTipoConflito');
        if (!ctx) return;

        // Destroy existing chart if it exists
        if (chart) {
            chart.destroy();
        }

        const labels = data.map(item => item.tipo_conf || 'Não especificado');
        const values = data.map(item => item.total || 0);

        chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Número de Conflitos',
                    data: values,
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(255, 205, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)',
                        'rgba(255, 159, 64, 0.8)'
                    ],
                    borderColor: [
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(255, 205, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Histograma de Conflitos por Tipo'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }

    // Reports functionality
    const reportButtons = document.querySelectorAll('[data-report]');
    const relatorioContainer = document.getElementById('relatorioContainer');
    const relatorioTitle = document.getElementById('relatorioTitle');
    const relatorioTableHead = document.getElementById('relatorioTableHead');
    const relatorioTableBody = document.getElementById('relatorioTableBody');

    reportButtons.forEach(button => {
        button.addEventListener('click', async () => {
            const reportType = button.getAttribute('data-report');
            await loadReport(reportType, button.textContent);
        });
    });

    async function loadReport(reportType, title) {
        let endpoint = '';
        let headers = [];
        let dataProcessor = null;

        switch (reportType) {
            case 'traficantes-armas':
                endpoint = 'estatisticas/arma-traficante';
                headers = ['Traficante', 'Sobrenome', 'Grupo Armado', 'Modelo da Arma'];
                dataProcessor = (item) => [
                    item.nome_traficante || 'N/A',
                    item.sobrenome || 'N/A',
                    item.nome_grupo_armado || 'N/A',
                    item.modelo_arma || 'N/A'
                ];
                break;
            
            case 'top-conflitos-mortos':
                endpoint = 'estatisticas/top-conflitos-mortos';
                headers = ['Nome do Conflito', 'Número de Mortos'];
                dataProcessor = (item) => [
                    item.nome || 'N/A',
                    item.nr_mortos || 0
                ];
                break;
            
            case 'top-organizacoes':
                endpoint = 'estatisticas/top-organizacoes';
                headers = ['Organização', 'Número de Mediações'];
                dataProcessor = (item) => [
                    item.nome || 'N/A',
                    item.numero_mediacoes || 0
                ];
                break;
            
            case 'top-grupos-armas':
                endpoint = 'estatisticas/top-grupos-armas';
                headers = ['Grupo Armado', 'Número de Armas'];
                dataProcessor = (item) => [
                    item.nome || 'N/A',
                    item.total_armas || 0
                ];
                break;
            
            case 'pais-religiosos':
                endpoint = 'estatisticas/pais-religiosos';
                headers = ['País', 'Número de Conflitos Religiosos'];
                dataProcessor = (item) => [
                    item.nome || 'N/A',
                    item.numero_conflitos_religiosos || 0
                ];
                break;
            
            default:
                alert('Relatório não implementado');
                return;
        }

        try {
            const res = await fetch(`${apiBase}/${endpoint}/`);
            if (res.ok) {
                const data = await res.json();
                displayReport(title, headers, data, dataProcessor);
            } else {
                alert('Erro ao carregar relatório');
            }
        } catch (error) {
            console.error('Erro:', error);
            alert('Erro de conexão. Verifique se o backend está rodando.');
        }
    }

    function displayReport(title, headers, data, dataProcessor) {
        // Update title
        relatorioTitle.textContent = title;

        // Create table headers
        relatorioTableHead.innerHTML = '';
        const headerRow = document.createElement('tr');
        headers.forEach(header => {
            const th = document.createElement('th');
            th.textContent = header;
            headerRow.appendChild(th);
        });
        relatorioTableHead.appendChild(headerRow);

        // Create table body
        relatorioTableBody.innerHTML = '';
        if (data && data.length > 0) {
            data.forEach(item => {
                const row = document.createElement('tr');
                const processedData = dataProcessor(item);
                processedData.forEach(cellData => {
                    const td = document.createElement('td');
                    td.textContent = cellData;
                    row.appendChild(td);
                });
                relatorioTableBody.appendChild(row);
            });
        } else {
            const row = document.createElement('tr');
            const td = document.createElement('td');
            td.colSpan = headers.length;
            td.textContent = 'Nenhum dado encontrado';
            td.classList.add('text-center');
            row.appendChild(td);
            relatorioTableBody.appendChild(row);
        }

        // Show the report container
        relatorioContainer.classList.remove('d-none');
    }
});
