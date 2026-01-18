import { useQuery } from "@tanstack/react-query";
import { Button } from "@/components/ui/Button";

interface HealthResponse {
  status: string;
}

async function fetchHealth(): Promise<HealthResponse> {
  const apiUrl = import.meta.env.VITE_API_URL || "http://localhost:8000";
  const response = await fetch(`${apiUrl}/health`);
  if (!response.ok) {
    throw new Error("Failed to fetch health status");
  }
  return response.json() as Promise<HealthResponse>;
}

export function Home() {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ["health"],
    queryFn: fetchHealth,
  });

  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-6 p-8">
      <h1 className="text-4xl font-bold">Welcome</h1>

      <div className="rounded-lg border bg-card p-6 text-card-foreground shadow-sm">
        <h2 className="mb-4 text-lg font-semibold">API Status</h2>

        {isLoading && <p className="text-muted-foreground">Checking...</p>}

        {error && (
          <p className="text-destructive">
            Error: {error instanceof Error ? error.message : "Unknown error"}
          </p>
        )}

        {data && (
          <p className="text-green-600 dark:text-green-400">
            Status: {data.status}
          </p>
        )}

        <Button onClick={() => refetch()} className="mt-4">
          Refresh
        </Button>
      </div>
    </div>
  );
}
