import axios from "axios";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import FieldInput from "./Input";
import FieldTextArea from "./TextArea";

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

const CVForm = () => {
  const { control, watch, setValue, handleSubmit } = useForm<FormData>();
  const [feedback, setFeedback] = useState<Feedback>({
    profile: "Wprowadż wartość, by poznać ocenę.",
    education: "Wprowadż wartość, by poznać ocenę.",
    experience: "Wprowadż wartość, by poznać ocenę.",
    skills: "Wprowadż wartość, by poznać ocenę.",
    contact: "Wprowadż wartość, by poznać ocenę.",
  });
  const [correctedFields, setCorrectedFields] = useState<Set<keyof FormData>>(
    new Set()
  );
  const watchedFields = watch();

  useEffect(() => {
    const debounce = setTimeout(() => {
      const fieldName = Object.keys(watchedFields).pop() as keyof FormData;
      const fieldValue = watchedFields[fieldName];

      if (fieldName && fieldName !== "fullname" && fieldValue) {
        axios
          .post<{ message: string }>("/api/validate-field", {
            field: fieldName,
            value: fieldValue,
          })
          .then((response) => {
            setFeedback((prev) => ({
              ...prev,
              [fieldName]: response.data.message,
            }));
          })
          .catch((err) => {
            console.error("Error validating field:", err);
          });
      }
    }, 2000);

    return () => clearTimeout(debounce);
  }, [watchedFields]);

  const onSubmit = async (data: FormData) => {
    try {
      const response = await axios.post<CorrectionResponse>(
        "/api/correct-cv",
        data
      );

      const updatedFields = new Set<keyof FormData>();
      for (const key in response.data) {
        if (response.data[key as keyof FormData]) {
          setValue(
            key as keyof FormData,
            response.data[key as keyof FormData] as string
          );
          updatedFields.add(key as keyof FormData);
        }
      }

      setCorrectedFields(updatedFields);
    } catch (error) {
      console.error("Error correcting CV:", error);
    }
  };
  return (
    <form onSubmit={handleSubmit(onSubmit)} className="card-container">
      <div className="center-wrap">
        <div className="form-container">
          <div className="form-column form-column-1">
            <FieldTextArea
              name="skills"
              control={control}
              placeholder="Umiejętności"
              feedback={feedback.skills}
              className={correctedFields.has("skills") ? "field-corrected" : ""}
            />
            <FieldTextArea
              name="contact"
              control={control}
              placeholder="Kontakt (np. numer telefonu, email)"
              feedback={feedback.contact}
              className={
                correctedFields.has("contact") ? "field-corrected" : ""
              }
            />
          </div>
          <div className="form-column form-column-2">
            <FieldInput
              name="fullname"
              control={control}
              placeholder="Pełne imię i nazwisko"
              className={
                correctedFields.has("fullname") ? "field-corrected" : ""
              }
            />
            <FieldInput
              name="title"
              control={control}
              placeholder="Tytuł (np. 'Fullstack Developer')"
              feedback={feedback.title}
              className={correctedFields.has("title") ? "field-corrected" : ""}
            />
            <FieldTextArea
              name="profile"
              control={control}
              placeholder="Profil (np. zainteresowania, krótki opis osoby)"
              feedback={feedback.profile}
              className={
                correctedFields.has("profile") ? "field-corrected" : ""
              }
            />
            <FieldTextArea
              name="experience"
              control={control}
              placeholder="Doświadczenie zawodowe"
              feedback={feedback.experience}
              className={
                correctedFields.has("experience") ? "field-corrected" : ""
              }
            />
            <FieldTextArea
              name="education"
              control={control}
              placeholder="Edukacja (np. studia, kursy)"
              feedback={feedback.education}
              className={
                correctedFields.has("education") ? "field-corrected" : ""
              }
            />
          </div>
          <button type="submit" className="btn">
            Popraw CV
          </button>
        </div>
      </div>
    </form>
  );
};

export default CVForm;
