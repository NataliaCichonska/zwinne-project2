import React from "react";

type PopUpAlertProps = { 
  isOpen: boolean;
  onClose: () => void;
  customText?: React.ReactNode;
  title?: string;
}

const PopUpAlert = ({ isOpen, onClose, customText, title }: PopUpAlertProps) => {
  if (!isOpen) return null; // Jeśli isOpen = false, nie renderuj nic

  return (
    <div style={{
      position: "fixed",
      top: "50%",
      left: "50%",
      transform: "translate(-50%, -50%)",
      padding: "20px",
      backgroundColor: "white",
      boxShadow: "0px 0px 10px rgba(0,0,0,0.2)",
      zIndex: 100
    }}>
      <h1 style={{
        color: "#fe4242",
        fontWeight: 800
      }}>{title || "Ostrzeżenie!"}</h1>
      <div style={{
        marginTop: "1rem",
        color: "#1f2029",
        fontWeight: 600
      }}>   
      {customText || "Szanowny Użytkowniku, informujemy, że wszelkie dane wprowadzane do formularza na tej stronie będą przesyłane do Chat GPT (firmy OpenAI) w celu ich przetworzenia i analizy. Prosimy o świadome wprowadzanie informacji, zwracając uwagę na ochronę danych osobowych oraz poufność przekazywanych treści. Jeśli nie wyrażasz zgody na przesyłanie danych, prosimy o niekorzystanie z formularza."}
      </div>
      <button onClick={onClose} style={{
        marginTop: "1rem",
        color: "#1f2029",
        fontWeight: 1000
      }}>OK</button>
    </div>
  );
};

export default PopUpAlert;
