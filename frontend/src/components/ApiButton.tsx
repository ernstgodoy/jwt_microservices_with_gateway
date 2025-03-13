import { useAuth0 } from "@auth0/auth0-react";

const gatewayUrl = import.meta.env.VITE_GATEWAY_URL;

const ApiButton = ({
  path,
  text,
  onApiResponse,
}: {
  path: string
  text: string
  onApiResponse: (data: any) => void
}) => {
  const { getAccessTokenSilently, isAuthenticated } = useAuth0()
  const makeApiCall = async () => {
    try {
      const token = isAuthenticated ? await getAccessTokenSilently() : null;
      const headers: HeadersInit = token ? {'Authorization': `Bearer ${token}`} : {}
      const response = await fetch(`${gatewayUrl}${path}`, {headers});
      const json = await response.json();
      onApiResponse(json)
    } catch (error) {
      onApiResponse(null)
    }
  }

  return <button onClick={makeApiCall}>{text}</button>;
};

export default ApiButton;