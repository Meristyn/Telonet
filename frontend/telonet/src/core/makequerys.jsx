import { fetchData } from "./fetchData";
import { useState, useEffect } from "react";

export default function Makequerys({ query }) {
  const [data, setData] = useState(null);

  useEffect(() => {
    if (!query) {
      console.error("No hay consulta definida");
      return;
    }

    fetchData(query)
      .then((data) => setData(data))
      .catch((error) => console.error("Error al obtener los datos:", error));
  }, [query]); // Escuchar cambios en query

  if (data === null) {
    return <div className="skeleton w-96 h-52"></div>;
  }

  const { columns, data: rows } = data;
  console.log(columns, data)

  return (
    <div className="overflow-x-auto">
      <table className="table table-zebra">
        <thead>
          <tr>
            {/* Renderizar encabezados dinámicamente */}
            {columns.map((col, index) => (
              <th key={index}>{col}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {/* Renderizar filas dinámicamente */}
          {rows.map((row, rowIndex) => (
            <tr key={rowIndex}>
              {row.map((cell, cellIndex) => (
                <td key={cellIndex}>{cell}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
