document.addEventListener('DOMContentLoaded', () => {
    const conflitoForm = document.getElementById('conflitoForm');
    const btnGrafico = document.getElementById('btnGraficoTipo');
    const apiBase = 'http://localhost:8000/api'; // Altere conforme necessário

    // Envia novo conflito
    conflitoForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const data = {
            nome: document.getElementById('nome').value,
            tipo_conf: document.getElementById('tipo').value,
            nr_mortos: parseInt(document.getElementById('nr_mortos').value),
            nr_feridos: parseInt(document.getElementById('nr_feridos').value),
        };
        const res = await fetch(`${apiBase}/conflitos/`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });
        alert(res.ok ? 'Conflito cadastrado!' : 'Erro ao cadastrar conflito');
        conflitoForm.reset();
    });

    // Gera gráfico de tipo de conflito
    btnGrafico.addEventListener('click', async () => {
        const res = await fetch(`${apiBase}/estatisticas/tipo-conflito`);
        const data = await res.json();

        const ctx = document.getElementById('graficoTipoConflito').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.map(e => e.tipo),
                datasets: [{
                    label: 'Número de Conflitos',
                    data: data.map(e => e.quantidade),
                }],
            },
        });
    });
});
