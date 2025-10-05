interface ProductPageProps {
  params: { id: string };
}

export default function ProductPage({ params }: ProductPageProps) {
  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-4">Product: {params.id}</h1>
      {/* TODO: Render product details here */}
    </div>
  );
} 