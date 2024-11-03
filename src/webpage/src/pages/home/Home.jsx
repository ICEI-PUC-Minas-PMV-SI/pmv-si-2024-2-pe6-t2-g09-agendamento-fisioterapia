
import styles from "./Home.module.css";
import React from "react";

const Home = () => {
  return (
    <div className={styles.container}>
      <section className={styles.hero}>
        <h1 className={styles.title}>Cuide da sua saúde com nosso atendimento especializado</h1>
        <p className={styles.subtitle}>
          Tratamentos personalizados para melhorar sua qualidade de vida.
        </p>
        <button className={styles.ctaButton}>Agende uma consulta</button>
      </section>

      <section className={styles.about}>
        <h2 className={styles.sectionTitle}>Sobre mim</h2>
        <div className={styles.aboutContent}>
          <div className={styles.imageContainer}>
            <img
              src="https://media-gig4-2.cdn.whatsapp.net/v/t61.24694-24/362807721_985445505987189_4674492870634223100_n.jpg?ccb=11-4&oh=01_Q5AaIMZQurZerAdkkZcYH7NqSsj1RyGtvDt95Hz5ek2wsq7n&oe=67268F83&_nc_sid=5e03e0&_nc_cat=111"
              alt="Fisioterapeuta Davi"
              className={styles.aboutImage}
            />
          </div>
          <p className={styles.sectionText}>
            Sou Davi Aburjeli, fisioterapeuta com 10 anos de experiência em avaliação e tratamento da dor.
            Nos últimos 5 anos, venho aprofundando o trabalho nos aspectos emocionais relacionados à dor, ajudando pessoas a viver com mais autonomia e menos dor.
          </p>
        </div>
      </section>

      <section className={styles.services}>
        <h2 className={styles.sectionTitle}>Serviços</h2>
        <ul className={styles.serviceList}>
          <li className={styles.serviceItem}>
            <img src="https://th.bing.com/th/id/OIP.bzoXys_iuacyzycO8pTfLQHaE7?rs=1&pid=ImgDetMain" alt="Reabilitação física" />
            <div className={styles.serviceText}>
              <h3>Reabilitação física</h3>
              <p>Programas personalizados para recuperação funcional e mobilidade.</p>
            </div>
          </li>
          <li className={styles.serviceItem}>
            <img src="https://th.bing.com/th/id/R.f45e0dd129337807d11686130b100c4b?rik=oA3L%2fjjoMJoSmQ&pid=ImgRaw&r=0" alt="Terapia manual" />
            <div className={styles.serviceText}>
              <h3>Terapia manual</h3>
              <p>Tratamento manual para aliviar a dor e restaurar o equilíbrio corporal.</p>
            </div>
          </li>
          <li className={styles.serviceItem}>
            <img src="https://th.bing.com/th/id/R.b923996c54498aee73ca96ae9800a205?rik=Gt%2b2SpfIIWoaXA&pid=ImgRaw&r=0" alt="Tratamento para dores crônicas" />
            <div className={styles.serviceText}>
              <h3>Dores crônicas</h3>
              <p>Soluções para aliviar dores persistentes e melhorar a qualidade de vida.</p>
            </div>
          </li>
          <li className={styles.serviceItem}>


            <img src="https://th.bing.com/th/id/R.2bb3e916215085959409926ad1ee2dc3?rik=vPM7d3kLMzHdyg&pid=ImgRaw&r=0" alt="Exercícios posturais" />
            <div className={styles.serviceText}>
              <h3>Exercícios posturais</h3>
              <p>Programas de reeducação postural para corrigir a postura e prevenir dores.</p>
            </div>
          </li>
        </ul>
      </section>

      <section className={styles.testimonials}>
        <h2 className={styles.sectionTitle}>Depoimentos</h2>
        <div className={styles.testimonialItem}>
          <p className={styles.testimonial}>
            "Excelente profissional! Minha dor nas costas melhorou muito com o tratamento."
          </p>
          <span className={styles.testimonialAuthor}>- Renato Cifuentes</span>
        </div>
        <div className={styles.testimonialItem}>
          <p className={styles.testimonial}>
            "Recomendo! Atendimento atencioso e resultados excelentes."
          </p>
          <span className={styles.testimonialAuthor}>- Gabriel Maia</span>
        </div>
      </section>

      <footer className={styles.footer}>
        <p>&copy; 2024 - Dr. Davi Aburjeli Fisioterapia. Todos os direitos reservados.</p>
      </footer>

      <div className={styles.whatsappBalloon}>
        <a href="https://wa.me/31996635156" target="_blank" rel="noopener noreferrer" className={styles.whatsappLink}>
          <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png" alt="WhatsApp" className={styles.whatsappIcon} />
          Agende sua consulta
        </a>
      </div>
    </div>
  );
};

export default Home;

