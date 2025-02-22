import axios from "axios";
import { useEffect, useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import FieldInput from "./Input";
import FieldTextArea from "./TextArea";
import PopUpAlert from "./PopUpAlert";

type FormData = {
  fullname: string;
  title: string;
  profile: string;
  education: string;
  experience: string;
  skills: string;
  contact: string;
};

type Feedback = {
  [key in keyof Omit<FormData, "fullname">]?: string;
};

type CorrectionResponse = Partial<FormData>;
type Response = { feedback: string; }
type FeedbackLines = string[]

const API_BASE_URL = process.env.REACT_APP_BACKEND_URL || "http://localhost:8080";

const CVForm = () => {
  const { control, watch, setValue, handleSubmit } = useForm<FormData>();
  const [feedback, setFeedback] = useState<Feedback>({
    profile: "Wprowadź wartość, by poznać ocenę.",
    education: "Wprowadź wartość, by poznać ocenę.",
    experience: "Wprowadź wartość, by poznać ocenę.",
    skills: "Wprowadź wartość, by poznać ocenę.",
    contact: "Wprowadź wartość, by poznać ocenę.",
  });

  const [response, setResponse] = useState<FeedbackLines>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [correctedFields, setCorrectedFields] = useState<Set<keyof FormData>>(new Set());
  const watchedFields = watch();

  useEffect(() => {
    const debounce = setTimeout(() => {
      const fieldName = Object.keys(watchedFields).pop() as keyof FormData;
      const fieldValue = watchedFields[fieldName];

      if (fieldName && fieldName !== "fullname" && fieldValue) {
        let validMessage = fieldValue ? "" : "Pole nie może być puste!";
        setFeedback((prev) => ({
          ...prev,
          [fieldName]: validMessage,
        }));
      }
    }, 2000);

    return () => clearTimeout(debounce);
  }, [watchedFields]);

  const onSubmit = async (data: FormData) => {
    try {
      setIsLoading(true);
      const response = await axios.post<Response>(
        `${API_BASE_URL}/api/correct-cv`,
        data
      );

      setResponse(response.data.feedback.split("\n"));
    } catch (error) {
      console.error("Error correcting CV:", error);
      setResponse(["Wystąpił błąd podczas poprawiania CV."]);
      console.error("Error correcting CV:", error);
      const response = (error as any)?.response;
      if (response?.status === 500) {
        setErrorPopUp(true);
        setErrorText(response.data.error ?? "ERROR");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const [disclaimerPopUp, setDisclaimerPopUp] = useState(false);
  const [errorPopUp, setErrorPopUp] = useState(false);
  const [errorText, setErrorText] = useState("");

  useEffect(() => {
    if (!localStorage.getItem("popupClosed")) {
      console.log("Pop-up powinien się otworzyć");
      setDisclaimerPopUp(true);  
    }
  }, []);

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="card-container" style={{ overflowY: "auto", maxHeight: "100vh" }}>
        <PopUpAlert isOpen={errorPopUp} customText={errorText} onClose={() => {setErrorPopUp(false);}} />
        <PopUpAlert isOpen={disclaimerPopUp} onClose={() => {setDisclaimerPopUp(false); localStorage.setItem("popupClosed", "true")}} />
      <div className="center-wrap">
        <div className="form-container" style={{ minHeight: "auto" }}>
          <div className="form-column form-column-1">
            <FieldTextArea name="skills" control={control} placeholder="Umiejętności" feedback={feedback.skills} className={correctedFields.has("skills") ? "field-corrected" : ""} />
            <FieldTextArea name="contact" control={control} placeholder="Kontakt (np. numer telefonu, email)" feedback={feedback.contact} className={correctedFields.has("contact") ? "field-corrected" : ""} />
          </div>
          <div className="form-column form-column-2">
            <FieldInput name="fullname" control={control} placeholder="Pełne imię i nazwisko" className={correctedFields.has("fullname") ? "field-corrected" : ""} />
            <FieldInput name="title" control={control} placeholder="Tytuł (np. 'Fullstack Developer')" feedback={feedback.title} className={correctedFields.has("title") ? "field-corrected" : ""} />
            <FieldTextArea name="profile" control={control} placeholder="Profil (np. zainteresowania, krótki opis osoby)" feedback={feedback.profile} className={correctedFields.has("profile") ? "field-corrected" : ""} />
            <FieldTextArea name="experience" control={control} placeholder="Doświadczenie zawodowe" feedback={feedback.experience} className={correctedFields.has("experience") ? "field-corrected" : ""} />
            <FieldTextArea name="education" control={control} placeholder="Edukacja (np. studia, kursy)" feedback={feedback.education} className={correctedFields.has("education") ? "field-corrected" : ""} />
          </div>
          <button type="submit" className="btn" disabled={isLoading}>{isLoading ? "Ładowanie" : "Popraw CV"}</button>
        </div>
        {/* Odpowiedź widoczna cały czas pod formularzem, szerokość równa formularzowi */}
        <div className="response-container" style={{ width: "100%", textAlign: "center", marginTop: "20px" }}>
          {response.length > 0 ? (
            response.map((line, i) => (
              <span key={i} className="response-text" style={{ display: "block", textAlign: "left", marginBottom: "5px" }}>
                {line}
              </span>
            ))
          ) : (
            <span className="response-text placeholder" style={{ display: "block" }}>Odpowiedź pojawi się tutaj</span>
          )}
        </div>
      </div>
    </form>
  );
};

export default CVForm;