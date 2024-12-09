import { useEffect, useState, useCallback } from "react";

export const useFetchAgendamento = (url) => {
  const [data, setData] = useState(null);
  const [config, setConfig] = useState(null);
  const [method, setMethod] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [itemId, setItemId] = useState(null);
  const [shouldReload, setShouldReload] = useState(false);

  const httpConfig = (dados, methodType, customUrl = null) => {
    const headers = { "Content-Type": "application/json" };
    const config = { method: methodType, headers };

    if (methodType === "POST" || methodType === "PUT") {
      if (!dados || typeof dados !== "object") {
        console.error("Os dados precisam ser um objeto válido.");
        return;
      }
      config.body = JSON.stringify(dados);
    } else if (methodType === "DELETE") {
      if (!dados) {
        console.error("Um ID é necessário para DELETE.");
        return;
      }
      setItemId(dados);
    }

    setConfig(config);
    setMethod(methodType);

    if (customUrl) {
      performFetch(customUrl, config); // Passa o config diretamente
    } else {
      setConfig(config); // Apenas se não for uma URL customizada
      setMethod(methodType);
    }

  };

  const performFetch = useCallback(
    async (requestUrl, customConfig = null) => {
      setLoading(true);
      try {
        const fetchConfig = customConfig || config;        
        const res = await fetch(requestUrl, fetchConfig);
        if (!res.ok) throw new Error(`Erro: ${res.status}`);
        if (method === "DELETE" || method === "POST" || method === "PUT") {
          setShouldReload(true);
        } else {
          const json = await res.json();
          setData(json);
        }

        setError(null);
      } catch (err) {
        console.error(err.message);
        setError(err.message);
      } finally {
        setLoading(false);
        setConfig(null);
        setMethod(null);
      }
    },
    [config, method]
  );

  useEffect(() => {
    if (!method || shouldReload) {     
      performFetch(url);
      setShouldReload(false);
    } else if (method === "POST" || method === "DELETE") {
      const targetUrl = method === "DELETE" ? `${url}` : url;
      performFetch(targetUrl);
    }
  }, [url, method, itemId, shouldReload, performFetch]);
  
  return { data, httpConfig, loading, error };
};
