document.addEventListener('DOMContentLoaded', () => {
    const apiBase = 'http://localhost:8000/api';

    // Function to handle form submission
    async function handleFormSubmit(formId, endpoint, dataBuilder) {
        const form = document.getElementById(formId);
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const data = dataBuilder();
            try {
                const res = await fetch(`${apiBase}/${endpoint}/`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data),
                });
                alert(res.ok ? 'Cadastro realizado com sucesso!' : 'Erro ao cadastrar');
                form.reset();
            } catch (error) {
                console.error('Erro:', error);
            }
        });
    }

    // Register conflict
    handleFormSubmit('conflitoForm', 'conflitos', () => ({
        nome: document.getElementById('nome').value,
        tipo_conf: document.getElementById('tipo').value,
        nr_mortos: parseInt(document.getElementById('nr_mortos').value),
        nr_feridos: parseInt(document.getElementById('nr_feridos').value),
    }));

    // Register group
    handleFormSubmit('grupoForm', 'grupos', () => ({
        nome: document.getElementById('nomeGrupo').value,
        descricao: document.getElementById('descricaoGrupo').value,
    }));

    // Register division
    handleFormSubmit('divisaoForm', 'divisoes', () => ({
        nome: document.getElementById('nomeDivisao').value,
        grupo: document.getElementById('grupoDivisao').value,
    }));

    // Register leadership
    handleFormSubmit('liderancaForm', 'liderancas', () => ({
        nome: document.getElementById('nomeLider').value,
        tipo: document.getElementById('tipoLider').value,
    }));

    // Register weapon
    handleFormSubmit('armaForm', 'armas', () => ({
        nome: document.getElementById('nomeArma').value,
        tipo: document.getElementById('tipoArma').value,
    }));
});
