import axios from "axios";
import { useState } from "react";
import { useDropzone } from "react-dropzone";

const CVUpload = () => {
  const [uploadedFile, setUploadedFile] = useState<File | null>(null);
  const [uploadedFilePreview, setUploadedFilePreview] = useState<string | null>(
    null
  );
  const [cvFeedback, setCvFeedback] = useState<string | null>(null);

  const onDrop = async (acceptedFiles: File[]) => {
    const file = acceptedFiles[0];
    if (!file) return;

    setUploadedFile(file);
    setUploadedFilePreview(URL.createObjectURL(file));

    try {
      const formData = new FormData();
      formData.append("file", file);

      //TODO Wysyłanie pliku do backendu
      const response = await axios.post<{ feedback: string }>(
        "/api/upload-cv",
        formData,
        {
          headers: { "Content-Type": "multipart/form-data" },
        }
      );

      setCvFeedback(response.data.feedback);
    } catch (error) {
      console.error("Error uploading CV:", error);
      setCvFeedback("Wystąpił błąd podczas przetwarzania pliku.");
    }
  };

  const { getRootProps, getInputProps } = useDropzone({
    onDrop,
    // @ts-ignore
    accept: ".png, .jpg, .jpeg",
  });

  const handleReset = () => {
    setUploadedFile(null);
    setUploadedFilePreview(null);
    setCvFeedback(null);
  };

  return (
    <div className="upload-container">
      {!uploadedFile ? (
        <div className="file-upload" {...getRootProps()}>
          <input {...getInputProps()} />
          <h4>
            Wgraj plik CV w formacie PNG lub JPG, by dokonać jego oceny
          </h4>
          <p>Przeciągnij plik lub kliknij, aby wybrać plik.</p>
        </div>
      ) : (
        <div className="file-preview-feedback">
          <div className="file-preview">
            <img
              src={uploadedFilePreview || ""}
              alt="Uploaded CV"
              className="a4-preview"
            />
          </div>
          <div className="cv-feedback">
            <h3>Ocena CV</h3>
            <p>{cvFeedback || "Przetwarzanie wgranego CV..."}</p>
          </div>
          <button
            className="btn absolute bottom-0 right-8"
            onClick={handleReset}
          >
            Wgraj nowy plik
          </button>
        </div>
      )}
    </div>
  );
};

export default CVUpload;
