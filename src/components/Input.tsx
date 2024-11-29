// @ts-nocheck

import { Control, Controller } from "react-hook-form";

type FieldProps = {
  name: string;
  control: any;
  placeholder: string;
  feedback?: string;
  className?: string;
};

const FieldInput: React.FC<FieldProps> = ({
  name,
  control,
  placeholder,
  feedback,
  className
}) => (
    <div className={`form-group ${className}`}>
    <Controller
      name={name}
      control={control}
      defaultValue=""
      render={({ field }) => (
        <input
          {...field}
          type="text"
          className="form-style"
          placeholder={placeholder}
        />
      )}
    />
    {feedback && <span className="caption">{feedback}</span>}
  </div>
);

export default FieldInput;
