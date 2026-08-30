import { createContext, useContext, ReactNode, useState, useEffect } from 'react';
import { signIn, signOut, getCurrentUser, fetchAuthSession } from 'aws-amplify/auth';

interface AuthContextType {
  user: any | null;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<any | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);

  useEffect(() => {
    checkUser();
  }, []);

  const checkUser = async () => {
    try {
      const currentUser = await getCurrentUser();
      const session = await fetchAuthSession();
      setUser(currentUser);
      setIsAuthenticated(true);
      if (session.tokens?.accessToken) {
        localStorage.setItem('jwtToken', session.tokens.accessToken.toString());
      }
    } catch {
      setUser(null);
      setIsAuthenticated(false);
      localStorage.removeItem('jwtToken');
    }
  };

  const login = async (email: string, password: string) => {
    await signIn({ username: email, password });
    await checkUser();
  };

  const logout = async () => {
    await signOut();
    setUser(null);
    setIsAuthenticated(false);
    localStorage.removeItem('jwtToken');
  };

  return (
    <AuthContext.Provider value={{ user, isAuthenticated, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
