import { useState } from "react";
import "./App.css";
import CVForm from "./components/CVForm";
import CVUpload from "./components/CVUpload";

function App() {
  const [selectedTab, setSelectedTab] = useState<0 | 1>(0);

  return (
    <div className="section">
      <div className="container">
        <div className="row full-height justify-content-center align-middle">
          <h6 className="position-fixed h6-sidebar">
            <span
              className={`cursor-pointer ${
                selectedTab === 0 ? "selectedTab" : ""
              }`}
              onClick={() => setSelectedTab(0)}
            >
              Stwórz CV
            </span>
            <br />
            <span
              className={`cursor-pointer ${
                selectedTab === 1 ? "selectedTab" : ""
              }`}
              onClick={() => setSelectedTab(1)}
            >
              Wgraj swoje CV
            </span>
          </h6>
          <div className="col-10 text-center align-self-center">
            <div className="section pb-2 pt-2 pt-sm-2 text-center">
              <div className="card-3d-wrap mx-auto">
                <div className="card-3d-wrapper">
                  {selectedTab === 0 && <CVForm />}
                  {selectedTab === 1 && (
                    <div className="card-container">
                      <div className="center-wrap">
                        <div className="section text-center">
                          <CVUpload />
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
