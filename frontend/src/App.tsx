import { useState } from 'react'
import './App.css'
import LoginButton from './components/Login'
import { useAuth0 } from '@auth0/auth0-react'
import LogoutButton from './components/Logout'
import ApiButton from './components/ApiButton'
import Profile from './components/Profile'

function App() {
  const { isAuthenticated } = useAuth0()
  const [data, setData] = useState<any>('Make api call');

  const handleApiResponse = (response: any) => {
    setData(response)
  }

  return (
    <>
      { !isAuthenticated ? ( 
        <LoginButton /> 
      ) : (
        <>
          <Profile />
          <LogoutButton />
        </>
      )}
      <div>
        <ApiButton path='/public' text='public api' onApiResponse={handleApiResponse}/>
        <ApiButton path='/private' text='private api' onApiResponse={handleApiResponse}/>
        <ApiButton path='/private_to_service_1' text='private to service 1' onApiResponse={handleApiResponse}/>
        <ApiButton path='/private_to_service_2' text='private to service 2' onApiResponse={handleApiResponse}/>
        <ApiButton path='/private_to_service_1_with_service_2' text='private to service 1 & 2' onApiResponse={handleApiResponse}/>
      </div>
      <code>{ JSON.stringify(data) }</code>
    </>
  )
}

export default App
