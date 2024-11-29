// @ts-nocheck

import { Controller } from "react-hook-form";

type FieldProps = {
  name: string;
  control: any;
  placeholder: string;
  feedback?: string;
  className?: string;
};

const FieldTextArea: React.FC<FieldProps> = ({
  name,
  control,
  placeholder,
  feedback,
  className,
}) => (
  <div className={`form-group ${className}`}>
    <Controller
      name={name}
      control={control}
      defaultValue=""
      render={({ field }) => (
        <textarea
          {...field}
          className="form-style"
          placeholder={placeholder}
        ></textarea>
      )}
    />
    {feedback && <span className="caption">{feedback}</span>}
  </div>
);

export default FieldTextArea;
