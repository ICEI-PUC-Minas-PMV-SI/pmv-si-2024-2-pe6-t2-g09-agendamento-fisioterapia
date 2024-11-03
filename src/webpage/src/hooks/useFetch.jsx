import { useEffect, useState, useCallback } from "react";

export const useFetch = (url) => {
  const [data, setData] = useState(null);
  const [config, setConfig] = useState(null);
  const [method, setMethod] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [itemId, setItemId] = useState(null);
  const [shouldReload, setShouldReload] = useState(false);

  const httpConfig = useCallback((dados, methodType) => {
    const headers = { "Content-Type": "application/json" };
    const newConfig = { method: methodType, headers };

    if (methodType === "POST" || methodType === "PUT") {
      if (!dados || typeof dados !== "object") {
        console.error("Os dados precisam ser um objeto válido.");
        return;
      }
      newConfig.body = JSON.stringify(dados);
    } else if (methodType === "DELETE") {
      if (!dados) {
        console.error("Um ID é necessário para DELETE.");
        return;
      }
      setItemId(dados);
    }

    setConfig(newConfig);
    setMethod(methodType);
  }, []);

  useEffect(() => {
    if (config && method) {
      performFetch(url, config);
    }
  }, [config, method, url]);

  const performFetch = useCallback(
    async (requestUrl, fetchConfig) => {
      setLoading(true);
      try {
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
        console.error("Erro na requisição:", err.message);
        setError(err.message);
      } finally {
        setLoading(false);
        setConfig(null); // Resetar config
        setMethod(null); // Resetar método
      }
    },
    [method]
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
